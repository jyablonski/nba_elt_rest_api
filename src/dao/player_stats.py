from sqlalchemy.orm import Session

from src.models import PlayerStats


def get_player_stats(db: Session, skip: int = 0, limit=250):
    return db.query(PlayerStats).offset(skip).limit(limit).all()
