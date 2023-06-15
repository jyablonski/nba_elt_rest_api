from fastapi import APIRouter, Depends, Request
from fastapi.responses import HTMLResponse
from sqlalchemy import func
from sqlalchemy.orm import Session

from src.database import get_db
from src.models import UserPastPredictions
from src.security import get_current_user_from_token
from src.utils import templates

router = APIRouter()


@router.get("/past_bets", response_class=HTMLResponse)
def get_user_past_bets_page(
    request: Request,
    username: str = Depends(get_current_user_from_token),
    db: Session = Depends(get_db),
):

    user_past_predictions = db.query(UserPastPredictions).filter(
        UserPastPredictions.username == username
    )

    user_past_predictions_count = user_past_predictions.count()
    user_past_predictions_success_count = user_past_predictions.filter(
        UserPastPredictions.is_correct_prediction == 1
    ).count()
    user_past_predictions_bet_profit = user_past_predictions.with_entities(
        func.sum(UserPastPredictions.bet_profit)
    ).scalar()
    print(user_past_predictions_bet_profit)

    if user_past_predictions_count == 0:
        user_past_predictions_pct_count = 0
    else:
        user_past_predictions_pct_count = round(
            user_past_predictions_success_count / user_past_predictions_count, 3
        )

    return templates.TemplateResponse(
        "past_bets.html",
        {
            "request": request,
            "past_predictions": user_past_predictions.order_by(
                UserPastPredictions.game_date.desc()
            ),
            "past_predictions_total_count": user_past_predictions_count,
            "past_predictions_success_count": user_past_predictions_success_count,
            "past_predictions_pct_count": user_past_predictions_pct_count,
            "past_predictions_bet_profit": user_past_predictions_bet_profit,
            "username": username,
        },
    )
