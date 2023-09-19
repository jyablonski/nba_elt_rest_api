from datetime import datetime, timedelta

from sqlalchemy.orm import Session

from src.models import Predictions


def get_predictions(db: Session):
    local_datetime = (datetime.utcnow() - timedelta(hours=5)).date()

    return (
        db.query(Predictions)
        .filter(Predictions.proper_date == str(local_datetime))
        .all()
    )
