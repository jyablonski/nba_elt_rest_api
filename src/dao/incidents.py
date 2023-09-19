from datetime import datetime

from sqlalchemy.orm import Session
from typing import List

from src import models


# incidents
def create_incident(
    db: Session,
    incident_name_form: str,
    incident_description_form: str,
    incident_is_active_form: int,
):
    created_timestamp = datetime.utcnow()

    record = models.Incidents(
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


def update_incident(db: Session, incidents_list: List[int]):
    modified_at = datetime.utcnow()

    incidents = db.query(models.Incidents).order_by(models.Incidents.incident_name)

    for incident, incident_update in zip(incidents, incidents_list):
        incident_update = int(incident_update)

        if incident.is_active == incident_update:
            continue

        incident.is_active = incident_update
        incident.modified_at = modified_at

        db.merge(incident)
        db.commit()

    return incidents
