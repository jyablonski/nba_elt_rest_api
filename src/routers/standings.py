from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache

from sqlalchemy.orm import Session

from src.cache import key_builder_no_db
from src.dao.standings import get_standings
from src.database import get_db
from src.schemas import StandingsBase

router = APIRouter()


@router.get("/standings", response_model=list[StandingsBase])
@cache(expire=900, key_builder=key_builder_no_db)
def read_standings(db: Session = Depends(get_db)):
    standings = get_standings(db)
    return standings
