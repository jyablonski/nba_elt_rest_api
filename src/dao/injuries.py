from sqlalchemy.orm import Session

from src.models import Injuries


def get_injuries(db: Session, skip: int = 0, limit=250):
    return db.query(Injuries).offset(skip).limit(limit).all()


def get_injuries_by_team(db: Session, team: str):
    return db.query(Injuries).filter(Injuries.team_acronym == team).first()
