from datetime import datetime, timezone
from fastapi import Form
from sqlalchemy.orm import Session

from . import models, schemas


def get_standings(db: Session):
    return db.query(models.Standings).all()


def get_scorers(db: Session, skip: int = 0, limit=250):
    return db.query(models.Scorers).offset(skip).limit(limit).all()


def get_team_ratings(db: Session):
    return db.query(models.Team_Ratings).all()


def get_team_ratings_by_team(db: Session, team: str):
    return (
        db.query(models.Team_Ratings)
        .filter(models.Team_Ratings.team_acronym == team)
        .first()
    )


def get_twitter_comments(db: Session, skip: int = 0, limit=250):
    return db.query(models.Twitter_Comments).offset(skip).limit(limit).all()


def get_reddit_comments(db: Session, skip: int = 0, limit=250):
    return db.query(models.Reddit_Comments).offset(skip).limit(limit).all()


def get_injuries(db: Session, skip: int = 0, limit=250):
    return db.query(models.Injuries).offset(skip).limit(limit).all()


def get_injuries_by_team(db: Session, team: str):
    return (
        db.query(models.Injuries).filter(models.Injuries.team_acronym == team).first()
    )


def get_game_types(db: Session):
    return db.query(models.Game_Types).all()

def send_feedback(db: Session, user_feedback: Form(...)):
    record = models.Feedback(
        feedback=user_feedback,
        time=datetime.now(timezone.utc)
    )
    db.add(record)
    db.commit()
    db.refresh(record)
    return record
