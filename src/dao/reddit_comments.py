from sqlalchemy.orm import Session

from src.models import Reddit_Comments


def get_reddit_comments(db: Session, skip: int = 0, limit=250):
    return db.query(Reddit_Comments).offset(skip).limit(limit).all()
