from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from src.crud import get_injuries, get_injuries_by_team
from src.database import get_db
from src.schemas import InjuriesBase
from src.utils import team_acronyms

router = APIRouter()


@router.get("/injuries", response_model=List[InjuriesBase])
def read_injuries(skip: int = 0, limit: int = 250, db: Session = Depends(get_db)):
    injuries = get_injuries(db, skip=skip, limit=limit)
    return injuries


@router.get("/injuries/{team}", response_model=InjuriesBase)
def read_team_ratings_team(team: str, db: Session = Depends(get_db)):
    injuries_team = get_injuries_by_team(db, team=team.upper())

    if team.upper() not in team_acronyms:
        raise HTTPException(
            status_code=404,
            detail=f"Team not found; please use a Team Acronym: {team_acronyms}",
        )
    elif injuries_team is None:
        raise HTTPException(status_code=200, detail=f"No Injury Data for {team}")
    else:
        return injuries_team
