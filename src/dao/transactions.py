from sqlalchemy.orm import Session

from src import models


def get_transactions(db: Session):
    return db.query(models.Transactions).all()
