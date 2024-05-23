from sqlalchemy.orm import Session

from src.models import Feedback


def get_feedback(db: Session) -> list[Feedback]:
    feedback = db.query(Feedback).all()

    return feedback


def send_feedback(db: Session, user_feedback: str) -> Feedback:
    record = Feedback(feedback=user_feedback)
    db.add(record)
    db.commit()
    db.refresh(record)
    return record
