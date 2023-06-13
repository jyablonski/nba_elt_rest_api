from typing import List

from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.crud import update_feature_flags
from src.database import get_db
from src.models import FeatureFlags
from src.security import get_current_user_from_token
from src.utils import templates

router = APIRouter()


@router.get("/admin/feature_flags", response_class=HTMLResponse)
def get_feature_flags(
    request: Request,
    username: str = Depends(get_current_user_from_token),
    db: Session = Depends(get_db),
):
    if username != "jyablonski":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You do not have the powa",
        )

    feature_flags = db.query(FeatureFlags)


    return templates.TemplateResponse(
        "feature_flags.html", {"request": request, "feature_flags": feature_flags}
    )


@router.post("/admin/feature_flags")
def post_feature_flags(
    request: Request,
    feature_flag_list: List[str] = Form(...),
    username: str = Depends(get_current_user_from_token),
    db: Session = Depends(get_db),
):
    if username != "jyablonski":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You do not have the powa",
        )

    update_feature_flags(db, feature_flag_list)

    return templates.TemplateResponse(
        "feature_flags.html",
        {
            "request": request,
            "feature_flag_response": "Feature Flags have been updated!",
        },
    )
