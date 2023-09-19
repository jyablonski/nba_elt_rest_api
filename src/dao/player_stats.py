from sqlalchemy.orm import Session

from src.models import Scorers


def get_player_stats(db: Session, skip: int = 0, limit=250):
    return db.query(Scorers).offset(skip).limit(limit).all()
