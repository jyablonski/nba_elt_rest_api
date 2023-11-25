from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.cache import key_builder_no_db
from src.dao.predictions import get_predictions
from src.database import get_db
from src.schemas import PredictionsBase

router = APIRouter()


@router.get("/predictions", response_model=list[PredictionsBase])
@cache(expire=900, key_builder=key_builder_no_db)
def read_predictions(db: Session = Depends(get_db)):
    predictions = get_predictions(db)
    return predictions
