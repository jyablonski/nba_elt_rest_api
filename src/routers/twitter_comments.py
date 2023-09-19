from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.dao.twitter_comments import get_twitter_comments
from src.database import get_db
from src.schemas import TwitterBase

router = APIRouter()


@router.get("/twitter_comments", response_model=List[TwitterBase])
def read_twitter_comments(
    skip: int = 0, limit: int = 250, db: Session = Depends(get_db)
):
    twitter_comments = get_twitter_comments(db, skip=skip, limit=limit)
    return twitter_comments
