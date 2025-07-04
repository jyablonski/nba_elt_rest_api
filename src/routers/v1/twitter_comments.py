from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from src.crud.twitter_comments import get_twitter_comments
from src.dependencies import get_db
from src.schemas import TwitterBase

router = APIRouter()


@router.get("/social/twitter/comments", response_model=list[TwitterBase])
def read_twitter_comments(
    skip: int = 0, limit: int = 250, db: Session = Depends(get_db)
) -> list[TwitterBase]:
    twitter_comments = get_twitter_comments(db, skip=skip, limit=limit)
    return twitter_comments
