from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.dao.player_stats import get_player_stats, get_player_stats_by_team
from src.dependencies import get_db, key_builder_no_db, validate_team_acronym
from src.schemas import PlayerStatsBase

router = APIRouter()


@router.get("/players/stats", response_model=list[PlayerStatsBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_player_stats(skip: int = 0, db: Session = Depends(get_db)):
    player_stats = get_player_stats(db, skip=skip)
    return player_stats


@router.get("/teams/{team}/players/stats", response_model=list[PlayerStatsBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_player_stats_by_team(
    team: str = Depends(validate_team_acronym),
    skip: int = 0,
    db: Session = Depends(get_db),
):
    player_stats = get_player_stats_by_team(db, team=team, skip=skip)
    return player_stats
