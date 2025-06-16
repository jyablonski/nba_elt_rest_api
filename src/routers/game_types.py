from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.dao.game_types import get_game_types, get_game_types_by_team
from src.dependencies import get_db, key_builder_no_db, validate_team_acronym
from src.schemas import GameTypesBase, TeamGameTypesBase

router = APIRouter()


@router.get("/league/game_types", response_model=list[GameTypesBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_game_types(db: Session = Depends(get_db)):
    game_types = get_game_types(db)
    return game_types


@router.get("/teams/{team}/game_types", response_model=list[TeamGameTypesBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_game_types_by_team(
    team: str = Depends(validate_team_acronym), db: Session = Depends(get_db)
):
    game_types = get_game_types_by_team(db=db, team=team)
    return game_types
