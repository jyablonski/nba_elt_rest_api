from datetime import datetime, timedelta, timezone

from sqlalchemy.orm import Session

from src.models import Predictions


def get_predictions(db: Session):
    local_datetime = (datetime.now(timezone.utc) - timedelta(hours=5)).date()

    return (
        db.query(Predictions).filter(Predictions.game_date == str(local_datetime)).all()
    )
