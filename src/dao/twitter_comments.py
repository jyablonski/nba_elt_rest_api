from sqlalchemy.orm import Session

from src.models import Twitter_Comments


def get_twitter_comments(db: Session, skip: int = 0, limit=250):
    return db.query(Twitter_Comments).offset(skip).limit(limit).all()
