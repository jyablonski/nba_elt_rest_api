from datetime import datetime, timedelta
import os
import secrets
from typing import Annotated, Dict, List, Optional

from fastapi import Depends, HTTPException, Request, status
from fastapi.openapi.models import OAuthFlows as OAuthFlowsModel
from fastapi.security import (
    HTTPBasic,
    OAuth2,
    OAuth2PasswordBearer,
)
from fastapi.security.utils import get_authorization_scheme_param
from jose import jwt
from jose import JWTError

from sqlalchemy.orm import Session

from .database import get_db
from .models import Users
from .utils import generate_hash_password

security = HTTPBasic()
oauth2_scheme_og = OAuth2PasswordBearer(tokenUrl="token")


class LoginForm:
    def __init__(self, request: Request):
        self.request: Request = request
        self.errors: List = []
        self.username: Optional[str] = None
        self.password: Optional[str] = None

    async def load_data(self):
        form = await self.request.form()
        self.username = form.get("username")
        self.password = form.get("password")

    async def is_valid(self):
        if not self.username:
            self.errors.append("Username is required")
        if not self.password or not len(self.password) > 0:
            self.errors.append("A valid password is required")
        if not self.errors:
            return True
        return False


def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=60,)

    data["exp"] = expire
    encoded_jwt = jwt.encode(data, os.environ.get("API_KEY"), algorithm="HS256",)

    return encoded_jwt


class OAuth2PasswordBearerWithCookie(OAuth2):
    def __init__(
        self,
        tokenUrl: str,
        scheme_name: Optional[str] = None,
        scopes: Optional[Dict[str, str]] = None,
        auto_error: bool = True,
    ):
        if not scopes:
            scopes = {}
        flows = OAuthFlowsModel(password={"tokenUrl": tokenUrl, "scopes": scopes})
        super().__init__(flows=flows, scheme_name=scheme_name, auto_error=auto_error)

    async def __call__(self, request: Request) -> Optional[str]:
        # skip the automatic error on login screen
        if "/login" in str(request.url):
            token: str = request.cookies.get("access_token")
            if token is not None:
                scheme, param = get_authorization_scheme_param(token)
                return param
            else:
                return None

        else:
            token: str = request.cookies.get(
                "access_token"
            )  # changed to accept access token from httpOnly Cookie

            scheme, param = get_authorization_scheme_param(token)
            if not token or scheme.lower() != "bearer":
                if self.auto_error:
                    raise HTTPException(
                        status_code=status.HTTP_401_UNAUTHORIZED,
                        detail="Not authenticated",
                        headers={"WWW-Authenticate": "Bearer"},
                    )
                else:
                    return None
            return param


def get_user(username: str, db: Session):
    user = db.query(Users).filter(Users.username == username).first()
    return user


oauth2_scheme = OAuth2PasswordBearerWithCookie(tokenUrl="token")


# this is the form / web app version to authenticate
# only difference is `oauth2_scheme` vs `oauth2_scheme_og`
def get_current_user_from_token(token: str = Depends(oauth2_scheme)) -> str:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    try:
        if token == None:
            return None

        payload = jwt.decode(token, os.environ.get("API_KEY"), algorithms=["HS256"])
        username: str = payload.get("sub")

        if username is None:
            raise credentials_exception
        else:
            return username

    except JWTError as e:
        print(f"JWT Error Occurred, {e}")
        raise credentials_exception


# this is the programmatic version to authenticate
async def get_current_user_from_api_token(
    token: Annotated[str, Depends(oauth2_scheme_og)]
) -> str:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, os.environ.get("API_KEY"), algorithms=["HS256"])
        username: str = payload.get("sub")

        if username is None:
            raise credentials_exception
        else:
            print(f"Returning username {username}")
            return username

    except JWTError:
        raise credentials_exception


def authenticate_user(username: str, password: str, db: Session = Depends(get_db)):
    user = get_user(username, db)

    if not user:
        return False

    password_request = generate_hash_password(password=password, salt=user.salt)

    user_password = (
        (db.query(Users).filter(Users.username == username)).first().password
    )

    correct_password = secrets.compare_digest(user_password, password_request)

    if not (correct_password):
        return False

    return user
