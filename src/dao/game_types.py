from sqlalchemy.orm import Session

from src.models import Game_Types


def get_game_types(db: Session):
    return db.query(Game_Types).all()
