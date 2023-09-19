from sqlalchemy.orm import Session

from src import models


def get_injuries(db: Session, skip: int = 0, limit=250):
    return db.query(models.Injuries).offset(skip).limit(limit).all()


def get_injuries_by_team(db: Session, team: str):
    return (
        db.query(models.Injuries).filter(models.Injuries.team_acronym == team).first()
    )
