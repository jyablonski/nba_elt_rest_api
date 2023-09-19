from datetime import datetime, timedelta

from sqlalchemy.orm import Session

from src import models


def get_predictions(db: Session):
    local_datetime = (datetime.utcnow() - timedelta(hours=5)).date()

    return (
        db.query(models.Predictions)
        .filter(models.Predictions.proper_date == str(local_datetime))
        .all()
    )
