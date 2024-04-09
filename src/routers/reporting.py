from fastapi import APIRouter, Depends, Form, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.dao.reporting import get_user_scheduled_reports
from src.database import get_db
from src.reporting import available_scheduled_reports
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.get("/reporting", response_class=HTMLResponse)
def get_reporting_page(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    username = creds["username"]
    current_user_scheduled_reports = get_user_scheduled_reports(
        db=db, username=username
    )
    return templates.TemplateResponse(
        "reporting.html",
        {
            "request": request,
            "current_reports": current_user_scheduled_reports,
            "available_scheduled_reports": available_scheduled_reports,
            "username": username,
        },
    )


# @router.get("/injuries/{team}", response_model=InjuriesBase)
# @cache(expire=900, key_builder=key_builder_no_db)
# async def read_team_ratings_team(team: str, db: Session = Depends(get_db)):
#     injuries_team = get_injuries_by_team(db, team=team.upper())

#     if team.upper() not in team_acronyms:
#         raise HTTPException(
#             status_code=404,
#             detail=f"Team not found; please use a Team Acronym: {team_acronyms}",
#         )
#     elif injuries_team is None:
#         raise HTTPException(status_code=200, detail=f"No Injury Data for {team}")
#     else:
#         return injuries_team
