from datetime import date

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.dao.schedule import get_schedule_for_date, get_yesterdays_schedule
from src.database import get_db
from src.schemas import ScheduleBase

router = APIRouter()


# couldnt cache here it kept failing, something to do with
# the datetime stuff i think
@router.get("/schedule", response_model=list[ScheduleBase])
def read_schedule(date: date | None = None, db: Session = Depends(get_db)):
    schedule = get_schedule_for_date(db=db, target_date=date)
    return schedule


@router.get("/yesterdays_schedule", response_model=list[ScheduleBase])
def read_yesterdays_schedule(db: Session = Depends(get_db)):
    schedule = get_yesterdays_schedule(db)
    return schedule


# def get_reddit_comments(
#     db: Session, skip: int = 0, limit: int = 250, text_filter: str | None = None
# ):
#     query = db.query(RedditComments)

#     if text_filter:
#         query = (
#             query.filter(RedditComments.comment.ilike(f"%{text_filter}%"))
#             .offset(skip)
#             .limit(limit)
#         )
#     else:
#         query = query.offset(skip).limit(limit)

#     return query.all()


# @router.get("/reddit_comments", response_model=list[RedditBase])
# @cache(expire=900, key_builder=key_builder_no_db)
# def read_reddit_comments(
#     skip: int = 0, limit: int = 250, filter: str = None, db: Session = Depends(get_db)
# ):
#     reddit_comments = get_reddit_comments(
#         db, skip=skip, limit=limit, text_filter=filter
#     )
#     return reddit_comments
