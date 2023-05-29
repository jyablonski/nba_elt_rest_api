from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.crud import get_reddit_comments
from src.database import get_db
from src.schemas import RedditBase

router = APIRouter()


@router.get("/reddit_comments", response_model=List[RedditBase])
def read_reddit_comments(
    skip: int = 0, limit: int = 250, db: Session = Depends(get_db)
):
    reddit_comments = get_reddit_comments(db, skip=skip, limit=limit)
    return reddit_comments
