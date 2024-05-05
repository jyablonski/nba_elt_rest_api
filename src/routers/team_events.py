from datetime import date

from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.dao.team_event_context import create_team_event_record, get_team_event_context
from src.database import get_db
from src.security import get_current_creds_from_token
from src.utils import team_acronyms, templates

router = APIRouter()


@router.get("/admin/team_events", response_class=HTMLResponse)
def get_team_events(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
) -> HTMLResponse:
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    return templates.TemplateResponse(  # type: ignore
        "team_events.html",
        {"request": request, "team_acronyms": team_acronyms},
    )


@router.post("/admin/team_events/create")
def post_team_events_create(  # noqa: F811
    request: Request,
    team_name_form: str = Form(...),
    team_event_form: str = Form(...),
    team_event_date_form: date = Form(...),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    create_team_event_record(
        db=db,
        team_name_form=team_name_form,
        team_event_form=team_event_form,
        team_event_date_form=team_event_date_form,
    )

    success_message = "Team event created successfully."
    return templates.TemplateResponse(
        "team_events.html", {"request": request, "success_message": success_message}
    )
