from sqlalchemy.orm import Session

from src.models import TwitterComments


def get_twitter_comments(db: Session, skip: int = 0, limit=250):
    return db.query(TwitterComments).offset(skip).limit(limit).all()
