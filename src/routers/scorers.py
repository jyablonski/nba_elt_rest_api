from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.crud import get_scorers
from src.database import get_db
from src.schemas import ScorersBase

router = APIRouter()


@router.get("/scorers", response_model=List[ScorersBase])
def read_scorers(skip: int = 0, db: Session = Depends(get_db)):
    scorers = get_scorers(db, skip=skip)
    return scorers
