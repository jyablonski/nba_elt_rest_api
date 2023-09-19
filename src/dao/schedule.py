from datetime import datetime

from sqlalchemy.orm import Session

from src.models import Schedule


def get_schedule(db: Session):
    return (
        db.query(
            Schedule.date,
            Schedule.day,
            Schedule.start_time,
            Schedule.avg_team_rank,
            Schedule.home_team,
            Schedule.home_moneyline_raw,
            Schedule.away_team,
            Schedule.away_moneyline_raw,
        )
        .filter(Schedule.date == datetime.utcnow().date())
        .all()
    )
