from datetime import date, datetime, timezone

from sqlalchemy.orm import Session

from src.models import TeamEventContext


def get_team_event_context(db: Session, team: str = "LAL") -> list[TeamEventContext]:
    return db.query(TeamEventContext).filter(TeamEventContext.team == team).all()


# incidents
def create_team_event_record(
    db: Session,
    team_name_form: str,
    team_event_form: str,
    team_event_date_form: date,
) -> TeamEventContext:
    created_timestamp = datetime.now(timezone.utc)

    record = TeamEventContext(
        team=team_name_form,
        event=team_event_form,
        event_date=team_event_date_form,
        created_at=created_timestamp,
        modified_at=created_timestamp,
    )

    db.add(record)
    db.commit()
    db.refresh(record)

    return record
