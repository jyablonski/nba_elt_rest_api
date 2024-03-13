from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.dao.incidents import create_incident, update_incident
from src.database import get_db
from src.models import Incidents
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.get("/admin/incidents", response_class=HTMLResponse)
def get_incidents(
    request: Request,
    creds: str = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
) -> HTMLResponse:
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    incidents = db.query(Incidents).order_by(Incidents.incident_name)

    return templates.TemplateResponse(
        "incidents.html", {"request": request, "incidents": incidents}
    )


@router.post("/admin/incidents")
def post_incidents(
    request: Request,
    incident_list: list[str] = Form(...),
    creds: str = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    new_incident = update_incident(db, incident_list)

    return templates.TemplateResponse(
        "incidents.html", {"request": request, "incidents": new_incident}
    )


@router.post("/admin/incidents/create")
def post_incidents_create(  # noqa: F811
    request: Request,
    incident_name_form: str = Form(...),
    incident_description_form: str = Form(...),
    incident_is_active_form: int = Form(...),
    creds: str = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    existing_incident = db.query(Incidents).order_by(Incidents.incident_name)

    existing_incident_check = existing_incident.filter(
        Incidents.incident_name == incident_name_form
    ).count()

    if existing_incident_check > 0:
        return templates.TemplateResponse(
            "incidents.html",
            {
                "request": request,
                "incidents": existing_incident,
                "incident_error": "You cannot store an Incident with that name!",
            },
        )

    create_incident(
        db, incident_name_form, incident_description_form, incident_is_active_form
    )

    incident = db.query(Incidents).order_by(Incidents.incident_name)

    return templates.TemplateResponse(
        "incidents.html", {"request": request, "incidents": incident}
    )
