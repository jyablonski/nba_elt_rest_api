from datetime import datetime
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, Form, Request
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.crud import create_user, delete_user, update_user
from src.database import get_db
from src.models import Users
from src.schemas import UserBase, UserCreate
from src.security import api_key_auth, get_current_username
from src.utils import templates

router = APIRouter()


@router.get("/users/login", response_class=HTMLResponse)
def user_login(request: Request):
    return templates.TemplateResponse("user_login.html", {"request": request})


@router.post("/users/login", response_class=HTMLResponse)
def user_login(
    request: Request,
    username: str = Form(...),
    password: Optional[str] = Form(...),
    db: Session = Depends(get_db),
):
    errors = []
    username_check = db.query(Users).filter(Users.username == username).first()

    if not username_check:
        errors.append(f"That Username does not exist")

        return templates.TemplateResponse(
            "user_login.html",
            {"request": request, "username": username, "errors": errors,},
        )

    username_check = (
        db.query(Users)
        .filter(Users.username == username)
        .filter(Users.password == password)
        .first()
    )

    if not username_check:
        errors.append(f"Wrong Password!")
        return templates.TemplateResponse(
            "user_login.html",
            {"request": request, "username": username, "errors": errors,},
        )

    return templates.TemplateResponse(
        "user_page.html", {"request": request, "username": username, "errors": errors,},
    )


@router.get("/users/create", response_class=HTMLResponse)
def user_create(request: Request):
    return templates.TemplateResponse("create_user.html", {"request": request})


@router.post("/users/create", response_model=UserCreate)
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

    return templates.TemplateResponse(
        "user_login.html", {"request": request, "username": username}
    )


@router.post("/users", response_model=UserCreate, status_code=201)
async def create_users(create_user_request: UserCreate, db: Session = Depends(get_db)):
    print(type(db))
    record_check = (
        db.query(Users).filter(Users.username == create_user_request.username).first()
    )

    if record_check:
        raise HTTPException(
            status_code=403,
            detail="Username already exists!  Please select another username.",
        )

    return create_user(db, create_user_request)


@router.put("/users/{username}", response_model=UserBase)
async def update_users(
    username: str, update_user_request: UserBase, db: Session = Depends(get_db)
):
    print(f"type db is {type(db)}")
    existing_user_record = db.query(Users).filter(Users.username == username).first()

    if not existing_user_record:
        raise HTTPException(
            status_code=400,
            detail="That old Username doesn't exist!  Please select another username.",
        )

    new_record_check = (
        db.query(Users).filter(Users.username == update_user_request.username).first()
    )

    if new_record_check:
        raise HTTPException(
            status_code=403,
            detail="The new requested Username already exists!  Please select another username.",
        )

    return update_user(db, existing_user_record, update_user_request)


@router.delete("/users/{username}", dependencies=[Depends(api_key_auth)])
def delete_users(
    username: str, db: Session = Depends(get_db),
):
    user_record = db.query(Users).filter(Users.username == username).first()

    if not user_record:
        raise HTTPException(
            status_code=400,
            detail="Username doesn't exist!  Please select another username.",
        )

    return delete_user(db, user_record)

@router.get("/users/me")
def read_current_user(username: str = Depends(get_current_username)):
    return {"username": username}