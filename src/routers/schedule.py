from datetime import date

from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.dao.schedule import get_schedule_for_date
from src.dependencies import get_db, key_builder_no_db
from src.schemas import ScheduleBase

router = APIRouter()


# couldnt cache here it kept failing, something to do with
# the datetime stuff i think
@router.get("/league/schedule", response_model=list[ScheduleBase])
@cache(expire=900, key_builder=key_builder_no_db)
def get_schedule(date: date | None = None, db: Session = Depends(get_db)):
    schedule = get_schedule_for_date(db=db, target_date=date)
    return schedule
