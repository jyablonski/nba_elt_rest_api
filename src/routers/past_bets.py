from fastapi import APIRouter, Depends, Request
from fastapi.responses import HTMLResponse
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

    # this logic checks if every game from today has already been selected or not
    # by the user, and then stores it as a cte for use in a query later
    user_past_predictions = (
        db.query(UserPastPredictions)
        .filter(UserPastPredictions.username == username)
        .order_by(UserPastPredictions.game_date.desc())
    )

    user_past_predictions_count = user_past_predictions.count()
    user_past_predictions_success_count = user_past_predictions.filter(UserPastPredictions.is_correct_prediction == 1).count()
    user_past_predictions_pct_count = round(user_past_predictions_success_count / user_past_predictions_count, 3)

    return templates.TemplateResponse(
        "past_bets.html",
        {
            "request": request,
            "past_predictions": user_past_predictions,
            "past_predictions_total_count": user_past_predictions_count,
            "past_predictions_success_count": user_past_predictions_success_count,
            "past_predictions_pct_count": user_past_predictions_pct_count,
            "username": username,
        },
    )