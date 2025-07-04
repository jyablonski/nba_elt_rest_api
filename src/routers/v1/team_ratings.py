from typing import List

from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.crud.team_ratings import get_team_ratings, get_team_ratings_by_team
from src.dependencies import get_db, key_builder_no_db, validate_team_acronym
from src.schemas import TeamRatingsBase

router = APIRouter()


# return all league team ratings
@router.get("/league/ratings", response_model=List[TeamRatingsBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_team_ratings(db: Session = Depends(get_db)):
    team_ratings = get_team_ratings(db)
    return team_ratings


# return team ratings by team acronym
@router.get("/teams/{team}/ratings", response_model=TeamRatingsBase)
@cache(expire=900, key_builder=key_builder_no_db)
async def read_team_ratings_team(
    team: str = Depends(validate_team_acronym), db: Session = Depends(get_db)
):
    team_ratings_team = get_team_ratings_by_team(db, team=team)
    return team_ratings_team
