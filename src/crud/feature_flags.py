from datetime import datetime, timezone

from sqlalchemy.orm import Session

from src.models.feature_flags import FeatureFlags


def get_all_feature_flags(db: Session) -> list[FeatureFlags]:
    return db.query(FeatureFlags).order_by(FeatureFlags.flag).all()


def feature_flag_exists(db: Session, flag_name: str) -> bool:
    return db.query(FeatureFlags).filter(FeatureFlags.flag == flag_name).count() > 0


def create_feature_flags(
    db: Session, feature_flag_name_form: str, feature_flag_is_enabled_form: int
):
    created_timestamp = datetime.now(timezone.utc)

    record = FeatureFlags(
        flag=feature_flag_name_form,
        is_enabled=feature_flag_is_enabled_form,
        created_at=created_timestamp,
        modified_at=created_timestamp,
    )

    db.add(record)
    db.commit()
    db.refresh(record)

    return record


def update_feature_flags(
    db: Session, feature_flags_list: list[int]
) -> list[FeatureFlags]:
    modified_at = datetime.now(timezone.utc)
    feature_flags = db.query(FeatureFlags).order_by(FeatureFlags.flag).all()

    for feature_flag, feature_flag_update in zip(feature_flags, feature_flags_list):
        feature_flag_update = int(feature_flag_update)
        if feature_flag.is_enabled != feature_flag_update:
            feature_flag.is_enabled = feature_flag_update
            feature_flag.modified_at = modified_at
            db.merge(feature_flag)

    db.commit()
    return feature_flags


def get_feature_flag(db: Session, flag_name: str) -> bool:
    """
    Function to retrieve the value of the specified feature
    flag from the database.

    Args:
        db (Session): Database Session Variable

        flag_name (str): Feature Flag Name from the `flag`
            column on the `FeatureFlags` Model

    Returns:
        Boolean of whether the Feature Flag is enabled or not
    """
    feature_flag = db.query(FeatureFlags).filter(FeatureFlags.flag == flag_name).first()
    if not feature_flag:
        # Feature flag not found, default to False
        return False
    return bool(feature_flag.is_enabled)
