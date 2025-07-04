from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from sqlalchemy.orm import Session
from typing import List

from src.crud.feature_flags import (
    create_feature_flags,
    update_feature_flags,
    get_all_feature_flags,
    feature_flag_exists,
)
from src.dependencies import get_db
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.post("/admin/feature_flags")
def update_feature_flags_post(
    request: Request,
    feature_flag_list: List[int] = Form(...),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    new_feature_flags = update_feature_flags(
        db=db, feature_flags_list=feature_flag_list
    )

    return templates.TemplateResponse(
        "feature_flags.html", {"request": request, "feature_flags": new_feature_flags}
    )


@router.post("/admin/feature_flags/create")
def create_feature_flags_post(
    request: Request,
    feature_flag_name_form: str = Form(...),
    feature_flag_is_enabled_form: int = Form(...),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    if feature_flag_exists(db=db, flag_name=feature_flag_name_form):
        existing_feature_flags = get_all_feature_flags(db=db)
        return templates.TemplateResponse(
            "feature_flags.html",
            {
                "request": request,
                "feature_flags": existing_feature_flags,
                "feature_flag_error": "You cannot store a Feature Flag with that name!",
            },
        )

    create_feature_flags(
        db=db,
        feature_flag_name_form=feature_flag_name_form,
        feature_flag_is_enabled_form=feature_flag_is_enabled_form,
    )
    feature_flags = get_all_feature_flags(db=db)

    return templates.TemplateResponse(
        "feature_flags.html", {"request": request, "feature_flags": feature_flags}
    )
