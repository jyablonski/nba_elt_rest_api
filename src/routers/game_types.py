from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.cache import key_builder_no_db
from src.dao.game_types import get_game_types
from src.database import get_db
from src.schemas import GameTypesBase

router = APIRouter()


@router.get("/game_types", response_model=list[GameTypesBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_game_types(db: Session = Depends(get_db)):
    game_types = get_game_types(db)
    return game_types
