from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.dao.schedule import get_schedule
from src.database import get_db
from src.schemas import ScheduleBase

router = APIRouter()


# couldnt cache here it kept failing, something to do with
# the datetime stuff i think
@router.get("/schedule", response_model=list[ScheduleBase])
def read_schedule(db: Session = Depends(get_db)):
    schedule = get_schedule(db)
    return schedule
