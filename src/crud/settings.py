from datetime import datetime, timezone

from sqlalchemy.orm import Session

from src.models.users import Users

# pacific = datetime.now(tz=pytz.timezone('America/Los_Angeles'))
# midwest = datetime.now(tz=pytz.timezone('America/Denver'))
# central = datetime.now(tz=pytz.timezone('America/Chicago'))
# eastern = datetime.now(tz=pytz.timezone('America/New_York'))
# utc = datetime.now(tz=pytz.timezone('UTC'))


def get_user_timezone(db: Session, username: str) -> str:
    user = db.query(Users).filter(Users.username == username).first()
    if user is None:
        raise ValueError(f"Username {username} not found")

    return user.timezone


def set_user_timezone(db: Session, username: str, selected_timezone: str) -> Users:
    user = db.query(Users).filter(Users.username == username).first()
    if user is None:
        raise ValueError(f"Username {username} not found")

    user.timezone = selected_timezone
    user.modified_at = datetime.now(timezone.utc)
    db.merge(user)
    db.commit()
    db.refresh(user)
    return user
