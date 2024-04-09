from datetime import datetime, timedelta

from sqlalchemy.orm import Session

from src.models import ScheduledReports


def get_user_scheduled_reports(db: Session, username: str) -> list[ScheduledReports]:
    return (
        db.query(ScheduledReports).filter(ScheduledReports.username == username).all()
    )
