from sqlalchemy.orm import Session

from src.models import GameTypes


def get_game_types(db: Session):
    return db.query(GameTypes).all()
