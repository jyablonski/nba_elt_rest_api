from datetime import datetime, timedelta
import hashlib
import os
import secrets
from typing import Dict, List, Optional

from fastapi import Depends, HTTPException, Request, status
from fastapi.openapi.models import OAuthFlows as OAuthFlowsModel
from fastapi.security import (
    HTTPBasic,
    HTTPBasicCredentials,
    OAuth2,
    OAuth2PasswordBearer,
)
from fastapi.security.utils import get_authorization_scheme_param
from fastapi.staticfiles import StaticFiles
from jose import jwt
from jose import JWTError

from sqlalchemy.orm import Session

from .database import get_db
from .models import Users
from .utils import generate_hash_password

security = HTTPBasic()
oauth2_scheme_og = OAuth2PasswordBearer(tokenUrl="token")


# async def verify_username(
#     request: Request, username: str, db: Session = Depends(get_db)
# ) -> HTTPBasicCredentials:
#     username_check = (db.query(Users).filter(Users.username == username)).first()

#     if username_check is None:
#         return None

#     user_password = (
#         (db.query(Users).filter(Users.username == username)).first().password
#     )

#     credentials = await security(request)

#     correct_username = secrets.compare_digest(credentials.username, username)
#     correct_password = secrets.compare_digest(credentials.password, user_password)

#     if not (correct_username and correct_password):
#         raise HTTPException(
#             status_code=status.HTTP_401_UNAUTHORIZED,
#             detail="Incorrect username or password",
#             headers={"WWW-Authenticate": "Basic"},
#         )
#     return credentials.username


# class AuthStaticFiles(StaticFiles):
#     def __init__(self, *args, **kwargs) -> None:

#         super().__init__(*args, **kwargs)

#     async def __call__(self, scope, receive, send) -> None:

#         assert scope["type"] == "http"
#         print(f"hi jaaacob ")
#         request = Request(scope, receive)
#         await verify_username(request)
#         await super().__call__(scope, receive, send)


def api_key_auth(api_key: str = Depends(oauth2_scheme_og),):
    api_keys: str = os.environ.get("API_KEY", "a")

    if api_key not in api_keys:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="Forbidden",
        )


def get_current_username(
    credentials: HTTPBasicCredentials = Depends(security), db: Session = Depends(get_db)
):
    username_check = (
        db.query(Users).filter(Users.username == credentials.username)
    ).first()

    if username_check is None:
        return None

    user_password = generate_hash_password(
        password=username_check.password, salt=username_check.salt
    )

    correct_password = secrets.compare_digest(credentials.password, user_password)
    if not (username_check and correct_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Basic"},
        )
    return credentials.username


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
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=60,)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, os.environ.get("API_KEY"), algorithm="HS256",)
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
        authorization: str = request.cookies.get(
            "access_token"
        )  # changed to accept access token from httpOnly Cookie

        scheme, param = get_authorization_scheme_param(authorization)
        if not authorization or scheme.lower() != "bearer":
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


oauth2_scheme = OAuth2PasswordBearerWithCookie(tokenUrl="/login/token")


def get_current_user_from_token(
    token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)
):
    print(token)

    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
    )

    try:
        payload = jwt.decode(token, os.environ.get("API_KEY"), algorithms=["HS256"])
        username: str = payload.get("sub")
        # print(f"username extracted is {username}")
        if username is None:
            raise credentials_exception

    except JWTError:
        raise credentials_exception

    user = get_user(username=username, db=db)

    if user is None:
        raise credentials_exception

    return user.username


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
