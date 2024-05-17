from __future__ import annotations

from datetime import datetime, timezone

from fastapi import APIRouter, Depends, Form, HTTPException, Request
from fastapi.responses import HTMLResponse, RedirectResponse
from sqlalchemy.orm import Session

from src.dao.feature_flags import get_feature_flag
from src.dao.users import create_user
from src.database import get_db
from src.models import Users
from src.schemas import UserCreate
from src.security import get_current_creds_from_token, LoginForm
from src.utils import templates
from src.routers.auth import login_for_access_token

router = APIRouter()


@router.get("/login")
def login(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    gmail_oauth_enabled = get_feature_flag(db, "gmail_oauth_login_form")
    if creds is not None:
        return templates.TemplateResponse(
            "login.html",
            {
                "request": request,
                "username": creds["username"],
                "role": creds["role"],
                "msg": "Login Successful",
            },
        )
    else:
        return templates.TemplateResponse(
            "login.html",
            {"request": request, "gmail_oauth_enabled": gmail_oauth_enabled},
        )


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


@router.get("/login/create_user", response_class=HTMLResponse)
def user_create(request: Request):
    return templates.TemplateResponse("create_user.html", {"request": request})


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

    record = Users(
        username=username,
        password=password,
        email=email,
        created_at=datetime.now(timezone.utc),
    )

    create_user(db=db, user=record)

    return RedirectResponse(
        "/login",
    )
