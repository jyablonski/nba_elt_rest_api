from datetime import datetime, timedelta, timezone

from fastapi import Form
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session
from typing import List

from . import models
from .schemas import UserBase, UserCreate
from .utils import generate_hash_password, generate_salt


def get_standings(db: Session):
    return db.query(models.Standings).all()


def get_scorers(db: Session, skip: int = 0, limit=250):
    return db.query(models.Scorers).offset(skip).limit(limit).all()


def get_team_ratings(db: Session):
    return db.query(models.Team_Ratings).all()


def get_team_ratings_by_team(db: Session, team: str):
    return (
        db.query(models.Team_Ratings)
        .filter(models.Team_Ratings.team_acronym == team)
        .first()
    )


def get_twitter_comments(db: Session, skip: int = 0, limit=250):
    return db.query(models.Twitter_Comments).offset(skip).limit(limit).all()


def get_reddit_comments(db: Session, skip: int = 0, limit=250):
    return db.query(models.Reddit_Comments).offset(skip).limit(limit).all()


def get_injuries(db: Session, skip: int = 0, limit=250):
    return db.query(models.Injuries).offset(skip).limit(limit).all()


def get_injuries_by_team(db: Session, team: str):
    return (
        db.query(models.Injuries).filter(models.Injuries.team_acronym == team).first()
    )


def get_game_types(db: Session):
    return db.query(models.Game_Types).all()


def send_feedback(db: Session, user_feedback: Form(...)):
    record = models.Feedback(feedback=user_feedback, time=datetime.now(timezone.utc))
    db.add(record)
    db.commit()
    db.refresh(record)
    return record


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


def get_predictions(db: Session):
    local_datetime = (datetime.utcnow() - timedelta(hours=5)).date()

    return (
        db.query(models.Predictions)
        .filter(models.Predictions.proper_date == str(local_datetime))
        .all()
    )


def get_transactions(db: Session):
    return db.query(models.Transactions).all()


def create_user(db: Session, user: UserCreate):
    salt = generate_salt()

    password_hash = generate_hash_password(password=user.password, salt=salt)

    record = models.Users(
        username=user.username,
        password=password_hash,
        email=user.email,
        salt=salt,
        created_at=user.created_at,
    )

    db.add(record)
    db.commit()
    db.refresh(record)

    # return the password that the user presented in the form instead of the salted hash
    record.password = user.password
    return record


def update_user(db: Session, user_record: UserBase, update_user_request: UserBase):
    update_user_encoded = jsonable_encoder(update_user_request)
    user_record.username = update_user_encoded["username"]
    user_record.password = update_user_encoded["password"]
    user_record.email = update_user_encoded["email"]

    updated_user = db.merge(user_record)
    db.commit()
    return updated_user


def delete_user(db: Session, user_record: UserBase):
    db.delete(user_record)
    db.commit()
    return f"Username {user_record.username} Successfully deleted!"


def store_bet_predictions(db: Session, bet_predictions: List[models.UserPredictions]):
    # this is so all records in this batch get the same timestamp
    created_at = datetime.utcnow()

    for prediction in bet_predictions:
        record = models.UserPredictions(
            username=prediction["username"],
            game_date=prediction["proper_date"],
            home_team=prediction["home_team"],
            home_team_odds=prediction["home_team_odds"],
            home_team_predicted_win_pct=prediction["home_team_predicted_win_pct"],
            away_team=prediction["away_team"],
            away_team_odds=prediction["away_team_odds"],
            away_team_predicted_win_pct=prediction["away_team_predicted_win_pct"],
            selected_winner=prediction["selected_winner"],
            bet_amount=prediction["bet_amount"],
            created_at=created_at,
        )
        db.add(record)
        db.commit()
        db.refresh(record)

    return record


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
