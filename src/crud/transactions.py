from sqlalchemy.orm import Session

from src.models.transactions import Transactions


def get_transactions(db: Session):
    return db.query(Transactions).all()
