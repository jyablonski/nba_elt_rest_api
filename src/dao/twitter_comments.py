from sqlalchemy.orm import Session

from src import models


def get_twitter_comments(db: Session, skip: int = 0, limit=250):
    return db.query(models.Twitter_Comments).offset(skip).limit(limit).all()
