from __future__ import annotations


from datetime import datetime
from typing import TYPE_CHECKING

from sqlalchemy.orm import Session

from src.models import Incidents

if TYPE_CHECKING:
    from sqlalchemy.orm import Query


# incidents
def create_incident(
    db: Session,
    incident_name_form: str,
    incident_description_form: str,
    incident_is_active_form: int,
):
    created_timestamp = datetime.utcnow()

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


def update_incident(db: Session, incidents_list: list[int]) -> Query[Incidents]:
    modified_at = datetime.utcnow()

    incidents = db.query(Incidents).order_by(Incidents.incident_name)

    for incident, incident_update in zip(incidents, incidents_list):
        incident_update = int(incident_update)

        if incident.is_active == incident_update:
            continue

        incident.is_active = incident_update
        incident.modified_at = modified_at

        db.merge(incident)
        db.commit()

    return incidents
