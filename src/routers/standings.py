from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.dao.standings import get_standings
from src.database import get_db
from src.schemas import StandingsBase

router = APIRouter()


@router.get("/standings", response_model=List[StandingsBase])
def read_standings(db: Session = Depends(get_db)):
    standings = get_standings(db)
    return standings
