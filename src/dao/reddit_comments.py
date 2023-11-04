from sqlalchemy.orm import Session

from src.models import RedditComments


def get_reddit_comments(db: Session, skip: int = 0, limit=250):
    return db.query(RedditComments).offset(skip).limit(limit).all()
