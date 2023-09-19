from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.dao.player_stats import get_player_stats
from src.database import get_db
from src.schemas import ScorersBase

router = APIRouter()


@router.get("/player_stats", response_model=List[ScorersBase])
def read_scorers(skip: int = 0, db: Session = Depends(get_db)):
    player_stats = get_player_stats(db, skip=skip)
    return player_stats
