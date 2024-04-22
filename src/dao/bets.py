from datetime import datetime, timezone

from sqlalchemy.orm import Session
from typing import Any

from src.models import UserPredictions


def store_bet_predictions(db: Session, bet_predictions: list[dict[str, Any]]) -> str:
    # this is so all records in this batch get the same timestamp
    created_at = datetime.now(timezone.utc)

    for prediction in bet_predictions:
        print(prediction)
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
        db.refresh(record)

    return f"Stored {len(bet_predictions)} Predictions"
