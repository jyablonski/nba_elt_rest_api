from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.dao.game_types import get_game_types
from src.database import get_db
from src.schemas import GameTypesBase

router = APIRouter()


@router.get("/game_types", response_model=List[GameTypesBase])
def read_game_types(db: Session = Depends(get_db)):
    game_types = get_game_types(db)
    return game_types
