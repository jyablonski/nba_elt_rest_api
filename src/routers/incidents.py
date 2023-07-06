from typing import List

from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.crud import create_incident, update_incident
from src.database import get_db
from src.models import Incidents
from src.security import get_current_user_from_token
from src.utils import templates

router = APIRouter()


@router.get("/admin/incidents", response_class=HTMLResponse)
def get_incidents(
    request: Request,
    username: str = Depends(get_current_user_from_token),
    db: Session = Depends(get_db),
):
    if username != "jyablonski":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="You do not have the powa",
        )

    incidents = db.query(Incidents).order_by(Incidents.incident_name)

    return templates.TemplateResponse(
        "incidents.html", {"request": request, "incidents": incidents}
    )


@router.post("/admin/incidents")
def post_incidents(
    request: Request,
    incident_list: List[str] = Form(...),
    username: str = Depends(get_current_user_from_token),
    db: Session = Depends(get_db),
):
    if username != "jyablonski":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="You do not have the powa",
        )

    new_incident = update_incident(db, incident_list)

    return templates.TemplateResponse(
        "incidents.html", {"request": request, "incidents": new_incident}
    )


@router.post("/admin/incidents/create")
def post_incidents(
    request: Request,
    incident_name_form: str = Form(...),
    incident_description_form: str = Form(...),
    incident_is_active_form: int = Form(...),
    username: str = Depends(get_current_user_from_token),
    db: Session = Depends(get_db),
):
    if username != "jyablonski":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED, detail="You do not have the powa",
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

    create_incident(db, incident_name_form, incident_description_form, incident_is_active_form)

    incident = db.query(Incidents).order_by(Incidents.incident_name)

    return templates.TemplateResponse(
        "incidents.html", {"request": request, "incidents": incident}
    )
