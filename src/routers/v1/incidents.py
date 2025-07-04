from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from typing import List
from sqlalchemy.orm import Session

from src.crud.incidents import (
    create_incident,
    update_incident,
    get_all_incidents,
    incident_exists,
)
from src.dependencies import get_db
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.post("/admin/incidents")
def post_incidents(
    request: Request,
    incident_list: List[int] = Form(...),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    new_incidents = update_incident(db=db, incidents_list=incident_list)

    return templates.TemplateResponse(
        "incidents.html", {"request": request, "incidents": new_incidents}
    )


@router.post("/admin/incidents/create")
def post_incidents_create(
    request: Request,
    incident_name_form: str = Form(...),
    incident_description_form: str = Form(...),
    incident_is_active_form: int = Form(...),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    if incident_exists(db=db, incident_name=incident_name_form):
        existing_incidents = get_all_incidents(db=db)
        return templates.TemplateResponse(
            "incidents.html",
            {
                "request": request,
                "incidents": existing_incidents,
                "incident_error": "You cannot store an Incident with that name!",
            },
        )

    create_incident(
        db=db,
        incident_name_form=incident_name_form,
        incident_description_form=incident_description_form,
        incident_is_active_form=incident_is_active_form,
    )
    incidents = get_all_incidents(db=db)

    return templates.TemplateResponse(
        "incidents.html", {"request": request, "incidents": incidents}
    )
