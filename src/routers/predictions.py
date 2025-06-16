from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.dao.predictions import get_predictions
from src.dependencies import get_db, key_builder_no_db
from src.schemas import PredictionsBase

router = APIRouter()


# this only returns predictions for the current date
# TODO: add a date param to get predictions for a specific date
@router.get("/league/predictions", response_model=list[PredictionsBase])
@cache(expire=900, key_builder=key_builder_no_db)
def read_predictions(db: Session = Depends(get_db)):
    predictions = get_predictions(db)
    return predictions
