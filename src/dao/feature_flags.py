from datetime import datetime

from sqlalchemy.orm import Session
from typing import List

from src import models


def create_feature_flags(
    db: Session, feature_flag_name_form: str, feature_flag_is_enabled_form: int
):
    created_timestamp = datetime.utcnow()

    record = models.FeatureFlags(
        flag=feature_flag_name_form,
        is_enabled=feature_flag_is_enabled_form,
        created_at=created_timestamp,
        modified_at=created_timestamp,
    )

    db.add(record)
    db.commit()
    db.refresh(record)

    return record


def update_feature_flags(db: Session, feature_flags_list: List[int]):
    modified_at = datetime.utcnow()

    feature_flags = db.query(models.FeatureFlags).order_by(models.FeatureFlags.flag)

    for feature_flag, feature_flag_update in zip(feature_flags, feature_flags_list):
        feature_flag_update = int(feature_flag_update)

        if feature_flag.is_enabled == feature_flag_update:
            continue

        feature_flag.is_enabled = feature_flag_update
        feature_flag.modified_at = modified_at

        db.merge(feature_flag)
        db.commit()

    return feature_flags
