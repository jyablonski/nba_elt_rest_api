from fastapi import APIRouter, Depends, Request
from fastapi.responses import HTMLResponse, RedirectResponse
from sqlalchemy.orm import Session
from sqlalchemy import func

from src.crud.predictions import (
    get_user_bets_context,
)
from src.models.predictions import UserPastPredictions
from src.dependencies import get_db
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.get("/bets", response_class=HTMLResponse)
async def get_user_bets_page(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    username = creds.get("username")
    if not username:
        return RedirectResponse("/login")

    context = get_user_bets_context(db, username=username, request=request)
    return templates.TemplateResponse("bets.html", context)


@router.get("/past_bets", response_class=HTMLResponse)
def get_user_past_bets_page(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    username = creds["username"]

    user_past_predictions = db.query(UserPastPredictions).filter(
        UserPastPredictions.username == username,
        UserPastPredictions.game_date >= "2023-10-01",
    )

    user_current_predictions = user_past_predictions.filter(
        UserPastPredictions.actual_winner == "TBD"
    ).count()

    user_past_predictions_aggs = user_past_predictions.filter(
        UserPastPredictions.actual_winner != "TBD"
    )

    user_past_predictions_count = user_past_predictions_aggs.count()
    user_past_predictions_success_count = user_past_predictions_aggs.filter(
        UserPastPredictions.is_correct_prediction == 1
    ).count()
    user_past_predictions_bet_profit = user_past_predictions_aggs.with_entities(
        func.sum(UserPastPredictions.bet_profit)
    ).scalar()

    if user_past_predictions_bet_profit == None:  # noqa: E711 mfer
        user_past_predictions_bet_profit = 0

    if user_past_predictions_count == 0:
        user_past_predictions_pct_count = 0
    else:
        user_past_predictions_pct_count = round(  # type: ignore
            user_past_predictions_success_count / user_past_predictions_count, 3
        )

    return templates.TemplateResponse(
        "past_bets.html",
        {
            "request": request,
            "past_predictions": user_past_predictions.order_by(
                UserPastPredictions.game_date.desc()
            ),
            "current_predictions_total_count": user_current_predictions,
            "past_predictions_total_count": user_past_predictions_count,
            "past_predictions_success_count": user_past_predictions_success_count,
            "past_predictions_pct_count": user_past_predictions_pct_count,
            "past_predictions_bet_profit": user_past_predictions_bet_profit,
            "username": username,
        },
    )
