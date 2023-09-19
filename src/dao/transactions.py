from sqlalchemy.orm import Session

from src.models import Transactions


def get_transactions(db: Session):
    return db.query(Transactions).all()
