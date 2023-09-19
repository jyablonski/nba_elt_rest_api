from sqlalchemy.orm import Session

from src import models


def get_player_stats(db: Session, skip: int = 0, limit=250):
    return db.query(models.Scorers).offset(skip).limit(limit).all()
