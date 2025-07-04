from __future__ import annotations

from datetime import datetime, timezone

from fastapi import APIRouter, Depends, Form, HTTPException, Request
from fastapi.responses import RedirectResponse
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from src.crud.feature_flags import get_feature_flag
from src.crud.users import create_user
from src.dependencies import get_db
from src.models.users import Users
from src.schemas import UserCreate
from src.security import LoginForm
from src.utils import templates
from src.routers.v1.auth import login_for_access_token

router = APIRouter()


@router.post("/login")
async def login_post(request: Request, db: Session = Depends(get_db)):  # noqa: F811
    gmail_oauth_enabled = get_feature_flag(db, "gmail_oauth_login_form")
    form = LoginForm(request)
    await form.load_data()

    if await form.is_valid():
        try:
            form.__dict__.update(msg="Login Successful")
            response = templates.TemplateResponse("login.html", form.__dict__)
            login_for_access_token(response=response, form_data=form, db=db)  # type: ignore
            return response
        except HTTPException:
            form.__dict__.update(msg="", gmail_oauth_enabled=gmail_oauth_enabled)
            form.__dict__.get("errors").append("Incorrect Username or Password")  # type: ignore
            return templates.TemplateResponse("login.html", form.__dict__)
    return templates.TemplateResponse("login.html", form.__dict__)


@router.post("/login/create_user", response_model=UserCreate)
def create_users_from_form(
    request: Request,
    username: str = Form(...),
    password: str = Form(...),
    email: str | None = Form(None),
    db: Session = Depends(get_db),
):
    record_check = db.query(Users).filter(Users.username == username).first()

    if record_check:
        raise HTTPException(
            status_code=403,
            detail="Username already exists!  Please select another username.",
        )

    user_details = UserCreate(
        username=username,
        password=password,
        email=email,
        created_at=datetime.now(timezone.utc),
    )

    create_user(db=db, user=user_details)

    form_data = OAuth2PasswordRequestForm(
        username=username,
        password=password,
        scope="",
        grant_type=None,
        client_id=None,
        client_secret=None,
    )

    # folow this redirect with a GET request, not a POST
    response = RedirectResponse(url="/login", status_code=303)
    login_for_access_token(response=response, form_data=form_data, db=db)

    return response
