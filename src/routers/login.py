from datetime import datetime
from typing import Optional

from fastapi import APIRouter, Depends, Form, HTTPException, Request
from fastapi.responses import HTMLResponse, RedirectResponse
from sqlalchemy.orm import Session

from src.crud import create_user
from src.database import get_db
from src.models import Users
from src.schemas import UserCreate
from src.security import get_current_user_from_token, LoginForm
from src.utils import templates
from src.routers.auth import login_for_access_token

router = APIRouter()


@router.get("/login")
def login(
    request: Request, username: str = Depends(get_current_user_from_token),
):
    if username is not None:
        return templates.TemplateResponse(
            "login.html",
            {"request": request, "username": username, "msg": "Login Successful"},
        )
    else:
        return templates.TemplateResponse("login.html", {"request": request})


@router.post("/login")
async def login(request: Request, db: Session = Depends(get_db)):
    form = LoginForm(request)
    await form.load_data()

    if await form.is_valid():
        try:
            form.__dict__.update(msg="Login Successful")
            response = templates.TemplateResponse("login.html", form.__dict__)
            login_for_access_token(response=response, form_data=form, db=db)
            return response
        except HTTPException:
            form.__dict__.update(msg="")
            form.__dict__.get("errors").append("Incorrect Username or Password")
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
    email: Optional[str] = Form(None),
    db: Session = Depends(get_db),
):
    record_check = db.query(Users).filter(Users.username == username).first()

    if record_check:
        raise HTTPException(
            status_code=403,
            detail="Username already exists!  Please select another username.",
        )

    record = Users(
        username=username, password=password, email=email, created_at=datetime.utcnow(),
    )

    create_user(db, record)

    return RedirectResponse("/login",)
