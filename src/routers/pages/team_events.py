from fastapi import APIRouter, Depends, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.crud.team_event_context import get_team_event_context
from src.dependencies import get_db
from src.security import get_current_creds_from_token
from src.utils import team_acronyms, templates

router = APIRouter()


@router.get("/admin/team_events", response_class=HTMLResponse)
def get_team_events(
    request: Request,
    team: str = "GSW",
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
) -> HTMLResponse:
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    events = get_team_event_context(db=db, team=team)
    return templates.TemplateResponse(  # type: ignore
        "team_events.html",
        {
            "request": request,
            "team_acronyms": team_acronyms,
            "events": events,
            "selected_team": team,
        },
    )
