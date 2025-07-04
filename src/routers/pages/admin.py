from fastapi import APIRouter, Depends, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.crud.feedback import get_feedback
from src.dependencies import get_db
from src.models.feature_flags import FeatureFlags
from src.models.incidents import Incidents
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.get("/admin", response_class=HTMLResponse)
def get_admin(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    return templates.TemplateResponse("admin.html", {"request": request})


@router.get("/admin/incidents", response_class=HTMLResponse)
def get_incidents(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
) -> HTMLResponse:
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    incidents = db.query(Incidents).order_by(Incidents.incident_name)

    return templates.TemplateResponse(  # type: ignore
        "incidents.html", {"request": request, "incidents": incidents}
    )


@router.get("/admin/feedback", response_class=HTMLResponse)
def get_admin_feedback(
    request: Request,
    db: Session = Depends(get_db),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    feedback = get_feedback(db=db)
    return templates.TemplateResponse(
        "admin_feedback.html", {"request": request, "all_feedback": feedback}
    )


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
