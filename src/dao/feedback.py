from datetime import datetime, timezone

from fastapi import Form
from sqlalchemy.orm import Session

from src import models


def send_feedback(db: Session, user_feedback: Form(...)):
    record = models.Feedback(feedback=user_feedback, time=datetime.now(timezone.utc))
    db.add(record)
    db.commit()
    db.refresh(record)
    return record
