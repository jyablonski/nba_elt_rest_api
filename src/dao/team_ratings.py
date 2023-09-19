from sqlalchemy.orm import Session

from src.models import Team_Ratings


def get_team_ratings(db: Session):
    return db.query(Team_Ratings).all()


def get_team_ratings_by_team(db: Session, team: str):
    return db.query(Team_Ratings).filter(Team_Ratings.team_acronym == team).first()
