from sqlalchemy.orm import Session

from src import models


def get_game_types(db: Session):
    return db.query(models.Game_Types).all()
