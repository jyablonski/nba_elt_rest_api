from typing import List

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from src.dao.team_ratings import get_team_ratings, get_team_ratings_by_team
from src.database import get_db
from src.schemas import TeamRatingsBase
from src.utils import team_acronyms

router = APIRouter()


@router.get("/team_ratings", response_model=List[TeamRatingsBase])
def read_team_ratings(db: Session = Depends(get_db)):
    team_ratings = get_team_ratings(db)
    return team_ratings


@router.get("/team_ratings/{team}", response_model=TeamRatingsBase)
def read_team_ratings_team(team: str, db: Session = Depends(get_db)):
    team_ratings_team = get_team_ratings_by_team(db, team=team.upper())
    if team not in team_acronyms:
        raise HTTPException(
            status_code=404,
            detail=f"Team not found; please use a Team Acronym: {team_acronyms}",
        )
    elif team_ratings_team is None:
        raise HTTPException(status_code=200, detail=f"No Team Ratings Data for {team}")
    else:
        return team_ratings_team
