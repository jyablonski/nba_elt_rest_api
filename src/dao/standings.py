from sqlalchemy.orm import Session

from src import models


def get_standings(db: Session):
    return db.query(models.Standings).all()
