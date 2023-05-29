from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.crud import get_predictions
from src.database import get_db
from src.schemas import PredictionsBase

router = APIRouter()


@router.get("/predictions", response_model=List[PredictionsBase])
def read_predictions(db: Session = Depends(get_db)):
    predictions = get_predictions(db)
    return predictions
