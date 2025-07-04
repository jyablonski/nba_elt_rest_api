from fastapi import APIRouter, Depends, Form, Request
from sqlalchemy.orm import Session

from src.crud.settings import set_user_timezone
from src.dependencies import get_db
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


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
        {
            "request": request,
            "username": username,
            "current_user_timezone": timezone,
            "msg": "Input Saved!",
        },
    )
