from datetime import datetime, timezone

from sqlalchemy.orm import Session

from src.models import Feedback


def send_feedback(db: Session, user_feedback: str):
    record = Feedback(feedback=user_feedback, time=datetime.now(timezone.utc))
    db.add(record)
    db.commit()
    db.refresh(record)
    return record
