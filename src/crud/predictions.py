from datetime import datetime, timedelta, timezone, date
from typing import Any

from fastapi import HTTPException
from sqlalchemy.orm import Session

from src.models.predictions import Predictions, UserPredictions


def get_todays_predictions(db: Session):
    local_datetime = (datetime.now(timezone.utc) - timedelta(hours=6)).date()

    return (
        db.query(Predictions).filter(Predictions.game_date == str(local_datetime)).all()
    )


def _get_today() -> date:
    return (datetime.now(timezone.utc) - timedelta(hours=6)).date()


def get_user_predictions(db: Session, username: str, date: date):
    return (
        db.query(UserPredictions)
        .filter(UserPredictions.game_date == date)
        .filter(UserPredictions.username == username)
    )


def check_user_predictions(db: Session, user_predictions_results, date: date):
    return (
        db.query(Predictions)
        .filter(Predictions.game_date == date)
        .join(
            user_predictions_results,
            Predictions.home_team == user_predictions_results.c.home_team,
            isouter=True,
        )
        .filter(user_predictions_results.c.game_date == None)  # noqa: E711
    )


def store_bet_predictions(db: Session, bet_predictions: list[dict[str, Any]]) -> str:
    created_at = datetime.now(timezone.utc)

    for prediction in bet_predictions:
        record = UserPredictions(
            username=prediction["username"],
            game_date=prediction["game_date"],
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
    return f"Stored {len(bet_predictions)} Predictions"


def get_user_bets_context(db: Session, username: str, request: Any) -> dict[str, Any]:
    today = _get_today()

    user_predictions_query = get_user_predictions(db, username, today)
    user_predictions_count = user_predictions_query.count()
    user_predictions_results = user_predictions_query.cte("user_predictions")

    total_games_today = (
        db.query(Predictions).filter(Predictions.game_date == today).count()
    )
    is_games_left = int(user_predictions_count < total_games_today)

    unpicked_games = check_user_predictions(db, user_predictions_results, today)

    return {
        "request": request,
        "games_today": unpicked_games,
        "is_games_left": is_games_left,
        "username": username,
    }


def process_user_bet_submission(
    db: Session,
    username: str,
    bet_predictions: list[str],
    bet_amounts: list[int],
) -> None:
    today = _get_today()

    user_predictions_query = get_user_predictions(db, username, today)
    user_predictions_count = user_predictions_query.count()
    user_predictions_results = user_predictions_query.cte("user_predictions")

    total_games_today = (
        db.query(Predictions).filter(Predictions.game_date == today).count()
    )
    if user_predictions_count >= total_games_today:
        raise HTTPException(
            status_code=403,
            detail="All Games for Today have been predicted already by this user!",
        )

    check_todays_predictions = check_user_predictions(
        db, user_predictions_results, today
    ).cte("user_remaining_games")

    predictions_list: list[dict[str, Any]] = []
    for prediction, bet_amount in zip(bet_predictions, bet_amounts):
        result = (
            db.query(check_todays_predictions)
            .filter(
                (check_todays_predictions.c.home_team == prediction)
                | (check_todays_predictions.c.away_team == prediction)
            )
            .first()
        )
        if result:
            result_dict = result._asdict()
            result_dict.update(
                {
                    "selected_winner": prediction,
                    "username": username,
                    "bet_amount": bet_amount,
                }
            )
            predictions_list.append(result_dict)

    store_bet_predictions(db, predictions_list)
