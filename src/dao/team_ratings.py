from sqlalchemy.orm import Session

from src import models


def get_team_ratings(db: Session):
    return db.query(models.Team_Ratings).all()


def get_team_ratings_by_team(db: Session, team: str):
    return (
        db.query(models.Team_Ratings)
        .filter(models.Team_Ratings.team_acronym == team)
        .first()
    )
