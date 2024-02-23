from datetime import datetime, timezone, timedelta

from fastapi import APIRouter, Depends, Request, Response
from fastapi.responses import RedirectResponse
from sqlalchemy.orm import Session

from src.database import get_db
from src.security import create_access_token, gmail_oauth
from src.dao.users import check_oauth_user, create_oauth_user

router = APIRouter()


@router.get("/login/google")
async def login_google(request: Request):
    redirect_uri = request.url_for("auth_google")
    return await gmail_oauth.google.authorize_redirect(request, redirect_uri)


@router.get("/auth_google")
async def auth_google(
    request: Request, response: Response, db: Session = Depends(get_db)
):
    token = await gmail_oauth.google.authorize_access_token(request)
    user = token["userinfo"]
    response = RedirectResponse("/login")
    user_email = user["email"]

    # if the user isnt verified then just return them back to /login
    if user["email_verified"] is True:
        # checking to see if the user exists in the database table
        # if not then create a user for them for our record
        does_user_exist = check_oauth_user(db=db, user_email=user_email)
        if does_user_exist is False:
            create_oauth_user(db=db, user_email=user_email)

        access_token_expires = datetime.now(timezone.utc) + timedelta(days=30)
        access_token = create_access_token(
            data={"sub": user["email"], "role": "Consumer"},
            expires=access_token_expires,
        )

        response.set_cookie(
            key="access_token",
            value=f"Bearer {access_token}",
            httponly=True,
            expires=access_token_expires,
        )

    return response
