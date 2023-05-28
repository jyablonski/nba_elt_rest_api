import os
import secrets

from fastapi import Depends, HTTPException, Request, status
from fastapi.security import HTTPBasic, HTTPBasicCredentials, OAuth2PasswordBearer
from fastapi.staticfiles import StaticFiles
from sqlalchemy.orm import Session

from .database import get_db
from .models import Users

security = HTTPBasic()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

async def verify_username(request: Request, username: str, db: Session = Depends(get_db)) -> HTTPBasicCredentials:

    user_password = (
        db.query(Users).filter(Users.username == username)
    ).first().password

    credentials = await security(request)

    correct_username = secrets.compare_digest(credentials.username, username)
    correct_password = secrets.compare_digest(credentials.password, user_password)

    if not (correct_username and correct_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Basic"},
        )
    return credentials.username


class AuthStaticFiles(StaticFiles):
    def __init__(self, *args, **kwargs) -> None:

        super().__init__(*args, **kwargs)

    async def __call__(self, scope, receive, send) -> None:

        assert scope["type"] == "http"

        request = Request(scope, receive)
        await verify_username(request)
        await super().__call__(scope, receive, send)


def api_key_auth(
    api_key: str = Depends(oauth2_scheme),
    api_keys: str = os.environ.get("API_KEY", "a"),
):
    if api_key not in api_keys:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="Forbidden"
        )
