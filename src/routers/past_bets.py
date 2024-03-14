from datetime import datetime

from fastapi import APIRouter, Depends, Request
from fastapi.responses import HTMLResponse, StreamingResponse, Response
from sqlalchemy import func
from sqlalchemy.orm import Session

from src.database import get_db
from src.models import UserPastPredictions
from src.security import get_current_creds_from_token
from src.utils import generate_csv, templates

router = APIRouter()


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


@router.post("/past_bets", response_class=StreamingResponse)
def post_user_past_bets_page(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    username = creds["username"]

    user_past_predictions = (
        (db.query(UserPastPredictions))
        .filter(UserPastPredictions.username == username)
        .order_by(UserPastPredictions.game_date.desc())
        .all()
    )
    date = datetime.utcnow().date()

    past_bet_cols = UserPastPredictions.__table__.c.keys()
    past_bet_cols.remove("id")

    csv_output = generate_csv(
        user_past_predictions, headers=past_bet_cols, report_date=date
    )

    return Response(
        content=csv_output,
        headers={
            "Content-Disposition": f"attachment; filename=bets-{username}-{date}.csv"
        },
        media_type="text/csv",
    )
