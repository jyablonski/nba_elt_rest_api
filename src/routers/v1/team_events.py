from datetime import date

from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from fastapi.responses import HTMLResponse, RedirectResponse
from sqlalchemy.orm import Session

from src.crud.team_event_context import create_team_event_record, get_team_event_context
from src.dependencies import get_db
from src.security import get_current_creds_from_token
from src.utils import team_acronyms, templates

router = APIRouter()


@router.post("/admin/team_events", response_class=HTMLResponse)
def post_team_events(
    request: Request,
    selected_team: str = Form(...),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
) -> HTMLResponse:
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    events = get_team_event_context(db=db, team=selected_team)
    return templates.TemplateResponse(  # type: ignore
        "team_events.html",
        {
            "request": request,
            "team_acronyms": team_acronyms,
            "events": events,
            "selected_team": selected_team,
        },
    )


@router.post("/admin/team_events/create")
def post_team_events_create(  # noqa: F811
    request: Request,
    selected_team: str = Form(...),
    event_form: str = Form(...),
    event_date_form: date = Form(...),
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
        team_name_form=selected_team,
        team_event_form=event_form,
        team_event_date_form=event_date_form,
    )

    return RedirectResponse(url="/v1/admin/team_events")
