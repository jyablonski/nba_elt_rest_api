from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.dao.feature_flags import create_feature_flags, update_feature_flags
from src.dependencies import get_db
from src.models import FeatureFlags
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.get("/admin/feature_flags", response_class=HTMLResponse)
def get_feature_flags(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    feature_flags = db.query(FeatureFlags).order_by(FeatureFlags.flag)

    return templates.TemplateResponse(
        "feature_flags.html", {"request": request, "feature_flags": feature_flags}
    )


@router.post("/admin/feature_flags")
def update_feature_flags_post(
    request: Request,
    feature_flag_list: list[int] = Form(...),
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
def create_feature_flags_post(  # noqa: F811
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

    existing_feature_flags = db.query(FeatureFlags).order_by(FeatureFlags.flag)

    existing_feature_flags_check = existing_feature_flags.filter(
        FeatureFlags.flag == feature_flag_name_form
    ).count()

    if existing_feature_flags_check > 0:
        return templates.TemplateResponse(
            "feature_flags.html",
            {
                "request": request,
                "feature_flags": existing_feature_flags,
                "feature_flag_error": "You cannot store a Feature Flag with that name!",
            },
        )

    create_feature_flags(db, feature_flag_name_form, feature_flag_is_enabled_form)

    feature_flags = db.query(FeatureFlags).order_by(FeatureFlags.flag)

    return templates.TemplateResponse(
        "feature_flags.html", {"request": request, "feature_flags": feature_flags}
    )
