from sqlalchemy.orm import Session

from src.models.injuries import Injuries


def get_injuries(db: Session, skip: int = 0, limit=250) -> list[Injuries]:
    return db.query(Injuries).offset(skip).limit(limit).all()


def get_injuries_by_team(db: Session, team: str) -> list[Injuries]:
    return db.query(Injuries).filter(Injuries.team_acronym == team).all()
