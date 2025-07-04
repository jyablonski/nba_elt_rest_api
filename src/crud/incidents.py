from sqlalchemy.orm import Session
from datetime import datetime, timezone
from src.models.incidents import Incidents


def get_all_incidents(db: Session) -> list[Incidents]:
    return db.query(Incidents).order_by(Incidents.incident_name).all()


def incident_exists(db: Session, incident_name: str) -> bool:
    return (
        db.query(Incidents).filter(Incidents.incident_name == incident_name).count() > 0
    )


def create_incident(
    db: Session,
    incident_name_form: str,
    incident_description_form: str,
    incident_is_active_form: int,
) -> Incidents:
    created_timestamp = datetime.now(timezone.utc)

    record = Incidents(
        incident_name=incident_name_form,
        incident_description=incident_description_form,
        is_active=incident_is_active_form,
        created_at=created_timestamp,
        modified_at=created_timestamp,
    )

    db.add(record)
    db.commit()
    db.refresh(record)

    return record


def update_incident(db: Session, incidents_list: list[int]) -> list[Incidents]:
    modified_at = datetime.now(timezone.utc)
    incidents = db.query(Incidents).order_by(Incidents.incident_name).all()

    for incident, incident_update in zip(incidents, incidents_list):
        incident_update = int(incident_update)
        if incident.is_active != incident_update:
            incident.is_active = incident_update
            incident.modified_at = modified_at
            db.merge(incident)

    db.commit()
    return incidents
