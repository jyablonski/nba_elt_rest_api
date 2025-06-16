from sqlalchemy.orm import Session

from src.models import Standings


def get_all_standings(db: Session) -> list[Standings]:
    return db.query(Standings).all()


def get_all_standings_by_team(db: Session, team: str) -> list[Standings]:
    return db.query(Standings).filter(Standings.team == team).all()
