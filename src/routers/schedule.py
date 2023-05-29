from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.crud import get_schedule
from src.database import get_db
from src.schemas import ScheduleBase

router = APIRouter()


@router.get("/schedule", response_model=List[ScheduleBase])
def read_schedule(db: Session = Depends(get_db)):
    schedule = get_schedule(db)
    return schedule
