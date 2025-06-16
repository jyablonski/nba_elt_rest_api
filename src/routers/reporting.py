from fastapi import APIRouter, Depends, Request
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.dao.reporting import get_reports
from src.dependencies import get_db
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
    available_reports = [report.report_name for report in get_reports(db=db)]
    print(available_reports)

    return templates.TemplateResponse(
        "reporting.html",
        {
            "request": request,
            "available_reports": available_reports,
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
