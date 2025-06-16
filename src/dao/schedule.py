from datetime import date, datetime, timezone

from sqlalchemy.orm import Session

from src.models import Schedule


def get_schedule_for_date(db: Session, target_date: date | None = None):
    if not target_date:
        target_date = datetime.now(timezone.utc).date()

    return db.query(Schedule).filter(Schedule.game_date == target_date).all()
