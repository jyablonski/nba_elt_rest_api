from sqlalchemy.orm import Session

from src.models import GameTypes, TeamGameTypes


def get_game_types(db: Session):
    return db.query(GameTypes).all()


def get_game_types_by_team(db: Session, team: str):
    return db.query(TeamGameTypes).filter(TeamGameTypes.team == team).all()
