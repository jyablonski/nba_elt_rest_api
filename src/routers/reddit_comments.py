from fastapi import APIRouter, Depends
from fastapi_cache.decorator import cache
from sqlalchemy.orm import Session

from src.cache import key_builder_no_db
from src.dao.reddit_comments import get_reddit_comments
from src.database import get_db
from src.schemas import RedditBase

router = APIRouter()


@router.get("/reddit_comments", response_model=list[RedditBase])
@cache(expire=900, key_builder=key_builder_no_db)
def read_reddit_comments(
    page: int = 1, limit: int = 250, filter: str = None, db: Session = Depends(get_db)
):
    reddit_comments = get_reddit_comments(
        db, page=page, limit=limit, text_filter=filter
    )
    return reddit_comments
