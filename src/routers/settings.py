from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.dao.settings import set_user_timezone
from src.database import get_db
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.get("/settings", response_class=HTMLResponse)
async def get_settings_page(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    username = creds["username"]
    print("hi")

    if username is None:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You do not have the powa",
        )

    return templates.TemplateResponse(
        "settings.html",
        {
            "request": request,
            "username": username,
        },
    )


@router.post("/settings")
def post_feature_flags(  # noqa: F811
    request: Request,
    timezone: str = Form(...),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    username = creds["username"]
    set_user_timezone(db=db, username=username, selected_timezone=timezone)

    return templates.TemplateResponse(
        "settings.html",
        {"request": request, "username": username, "msg": "Input Saved!"},
    )
