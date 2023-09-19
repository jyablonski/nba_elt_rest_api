from sqlalchemy.orm import Session

from src.models import Standings


def get_standings(db: Session):
    return db.query(Standings).all()
