from __future__ import annotations

from fastapi import APIRouter, Depends, Request
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.crud.feature_flags import get_feature_flag
from src.dependencies import get_db
from src.security import get_current_creds_from_token
from src.utils import templates

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


@router.get("/login/create_user", response_class=HTMLResponse)
def user_create(request: Request):
    return templates.TemplateResponse("create_user.html", {"request": request})
