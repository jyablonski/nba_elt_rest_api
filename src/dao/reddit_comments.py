from sqlalchemy.orm import Session

from src import models


def get_reddit_comments(db: Session, skip: int = 0, limit=250):
    return db.query(models.Reddit_Comments).offset(skip).limit(limit).all()
