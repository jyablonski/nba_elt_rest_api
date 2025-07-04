from datetime import datetime
import os
import secrets
from typing import Annotated, Any


from authlib.integrations.starlette_client import OAuth  # type: ignore
from fastapi import Depends, HTTPException, Request, status
from starlette.datastructures import UploadFile
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

from src.dependencies import get_db
from src.models.users import Users
from src.utils import generate_hash_password

security = HTTPBasic()
oauth2_scheme_og = OAuth2PasswordBearer(tokenUrl="token")
gmail_oauth = OAuth()
gmail_oauth.register(
    name="google",
    server_metadata_url="https://accounts.google.com/.well-known/openid-configuration",
    client_id=os.environ.get("GMAIL_OAUTH_ID"),
    client_secret=os.environ.get("GMAIL_OAUTH_CLIENT_SECRET"),
    client_kwargs={
        "scope": "email openid profile",
        "redirect_url": os.environ.get("GMAIL_OAUTH_REDIRECT_URL"),
    },
)


class LoginForm:
    def __init__(self, request: Request):
        self.request: Request = request
        self.errors: list = []
        self.username: str | UploadFile | None = None
        self.password: str | UploadFile | None = None

    async def load_data(self) -> str | UploadFile | None:
        form = await self.request.form()
        self.username = form.get("username")
        self.password = form.get("password")
        return self.username

    async def is_valid(self) -> bool:
        if not self.username:
            self.errors.append("Username is required")
        if not self.password or not len(str(self.password)) > 0:
            self.errors.append("A valid password is required")
        if not self.errors:
            return True
        return False


def create_access_token(data: dict[str, str], expires: datetime) -> str:
    data["exp"] = expires  # type: ignore
    encoded_jwt = jwt.encode(
        claims=data,
        key=os.environ.get("API_KEY", "a"),
        algorithm="HS256",
    )

    return encoded_jwt


class OAuth2PasswordBearerWithCookie(OAuth2):
    def __init__(
        self,
        tokenUrl: str,
        scheme_name: str | None = None,
        scopes: dict[str, str] | None = None,
        auto_error: bool = True,
    ):
        if not scopes:
            scopes = {}
        flows = OAuthFlowsModel(password={"tokenUrl": tokenUrl, "scopes": scopes})  # type: ignore
        super().__init__(flows=flows, scheme_name=scheme_name, auto_error=auto_error)

    async def __call__(self, request: Request) -> str | None:
        token = request.cookies.get("access_token")
        if "/login" in str(request.url):
            if token is not None:
                scheme, param = get_authorization_scheme_param(token)
                return param
            else:
                return None

        else:
            scheme, param = get_authorization_scheme_param(token)
            if not token or scheme.lower() != "bearer":
                if self.auto_error:
                    raise HTTPException(
                        status_code=status.HTTP_302_FOUND,
                        headers={"Location": "/login"},
                    )
                else:
                    return None
            return param


def get_user(username: str, db: Session) -> Users | None:
    user = db.query(Users).filter(Users.username == username).first()
    return user


oauth2_scheme = OAuth2PasswordBearerWithCookie(tokenUrl="token")


def get_current_creds_from_token(
    token: str = Depends(oauth2_scheme),
) -> dict[str, Any | None]:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    try:
        if token is None:
            return None

        payload = jwt.decode(
            token, os.environ.get("API_KEY", "a"), algorithms=["HS256"]
        )

        if payload.get("role") is None or payload.get("sub") is None:
            raise credentials_exception

        creds = {
            "role": payload.get("role"),
            "username": payload.get("sub"),
            "exp": payload.get("exp"),
        }
        return creds

    except JWTError as e:
        print(f"JWT Error Occurred, {e}")
        raise credentials_exception


# this is the programmatic version to authenticate
async def get_current_user_from_api_token(
    token: Annotated[str | bytes, Depends(oauth2_scheme_og)],
) -> str:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(
            token, os.environ.get("API_KEY", "a"), algorithms=["HS256"]
        )
        username = payload.get("sub")

        if username is None:
            raise credentials_exception
        else:
            return username

    except JWTError:
        raise credentials_exception


def authenticate_user(
    username: str, password: str, db: Session = Depends(get_db)
) -> Users:
    user = get_user(username=username, db=db)

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
        )

    password_request = generate_hash_password(password=password, salt=user.salt)

    user_password = (
        (db.query(Users).filter(Users.username == username)).first().password  # type: ignore
    )

    correct_password = secrets.compare_digest(user_password, password_request)

    if not correct_password:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
        )

    return user


def check_creds(creds: dict[str, str], check_type: str = "Username") -> None:
    """
    Helper Function to use in Protected Endpoints to check Credentials for either
    a Username or an Admin Role.

    Args:
        creds: Credentials provided by the Function via
            `creds: str = Depends(get_current_creds_from_token),`

        check_type (str): Variable to specify to check for either
            `Username` or `Admin`

    Returns:
        None

    Example:

        >>> check_creds(creds=creds, check_type="Admin")
    """
    if check_type == "Username":
        if not creds["username"]:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED)

    elif check_type == "Admin":
        if creds["role"] != "Admin":
            raise HTTPException(status.HTTP_403_FORBIDDEN)

    else:
        raise ValueError("Please use either `Username` or `Admin` for check_type")
