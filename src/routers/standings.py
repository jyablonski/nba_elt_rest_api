from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache

from sqlalchemy.orm import Session

from src.dao.standings import get_all_standings, get_all_standings_by_team
from src.dependencies import get_db, key_builder_no_db, validate_team_acronym
from src.schemas import StandingsBase

router = APIRouter()


@router.get("/league/standings", response_model=list[StandingsBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def get_standings(db: Session = Depends(get_db)):
    standings = get_all_standings(db)
    return standings


@router.get("/teams/{team}/standings", response_model=list[StandingsBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def get_standings_by_team(
    team: str = Depends(validate_team_acronym), db: Session = Depends(get_db)
):
    standings = get_all_standings_by_team(db, team=team)
    return standings
