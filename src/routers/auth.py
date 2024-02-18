from datetime import datetime, timedelta, timezone

from fastapi import APIRouter, Depends, HTTPException, Response, status
from fastapi.responses import RedirectResponse
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from src.database import get_db
from src.schemas import Token
from src.security import (
    authenticate_user,
    create_access_token,
)

router = APIRouter()


@router.post("/token", response_model=Token)
def login_for_access_token(
    response: Response,
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db),
):
    user = authenticate_user(form_data.username, form_data.password, db)

    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
        )

    # 2 things here:
    # the (jwt) access token is set as a cookie in the user's browser
    # and is set to expire after 30 days

    # the server then reads that access token and checks that the exp
    # on the token is not > 30 days old
    access_token_expires = datetime.now(timezone.utc) + timedelta(days=30)
    access_token = create_access_token(
        data={"sub": user.username, "role": user.role}, expires=access_token_expires
    )
    response.set_cookie(
        key="access_token",
        value=f"Bearer {access_token}",
        httponly=True,
        expires=access_token_expires,
    )
    return {"access_token": access_token, "token_type": "bearer"}


# this only works with 302 found lol, if you change it to 307 it fucks a bunch of a shit up
# wild.
@router.post("/logout")
async def logout(response: Response):
    response = RedirectResponse(url="/login", status_code=status.HTTP_302_FOUND)
    response.delete_cookie("access_token")
    return response
