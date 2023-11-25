from datetime import datetime, timezone

from sqlalchemy.orm import Session

from src.models import Schedule


def get_schedule(db: Session):
    return (
        db.query(
            Schedule.game_date,
            Schedule.day_name,
            Schedule.start_time,
            Schedule.avg_team_rank,
            Schedule.home_team,
            Schedule.home_moneyline_raw,
            Schedule.away_team,
            Schedule.away_moneyline_raw,
        )
        .filter(Schedule.game_date == datetime.now(timezone.utc).date())
        .all()
    )
