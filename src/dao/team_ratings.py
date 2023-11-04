from sqlalchemy.orm import Session

from src.models import TeamRatings


def get_team_ratings(db: Session):
    return db.query(TeamRatings).all()


def get_team_ratings_by_team(db: Session, team: str):
    return db.query(TeamRatings).filter(TeamRatings.team_acronym == team).first()
