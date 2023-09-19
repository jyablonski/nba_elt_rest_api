from datetime import datetime

from sqlalchemy.orm import Session

from src import models


def get_schedule(db: Session):
    return (
        db.query(
            models.Schedule.date,
            models.Schedule.day,
            models.Schedule.start_time,
            models.Schedule.avg_team_rank,
            models.Schedule.home_team,
            models.Schedule.home_moneyline_raw,
            models.Schedule.away_team,
            models.Schedule.away_moneyline_raw,
        )
        .filter(models.Schedule.date == datetime.utcnow().date())
        .all()
    )
