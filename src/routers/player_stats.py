from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.cache import key_builder_no_db
from src.dao.player_stats import get_player_stats
from src.database import get_db
from src.schemas import PlayerStatsBase

router = APIRouter()


@router.get("/player_stats", response_model=list[PlayerStatsBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_player_stats(skip: int = 0, db: Session = Depends(get_db)):
    player_stats = get_player_stats(db, skip=skip)
    return player_stats
