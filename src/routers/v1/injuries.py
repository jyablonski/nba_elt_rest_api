from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.crud.injuries import get_injuries, get_injuries_by_team
from src.dependencies import key_builder_no_db, get_db, validate_team_acronym
from src.schemas import InjuriesBase

router = APIRouter()


@router.get("/league/injuries", response_model=list[InjuriesBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_injuries(skip: int = 0, limit: int = 250, db: Session = Depends(get_db)):
    injuries = get_injuries(db, skip=skip, limit=limit)
    return injuries


@router.get("/teams/{team}/injuries", response_model=list[InjuriesBase])
@cache(expire=900, key_builder=key_builder_no_db)
async def read_team_ratings_team(
    team: str = Depends(validate_team_acronym), db: Session = Depends(get_db)
):
    injuries_team = get_injuries_by_team(db, team=team.upper())

    return injuries_team
