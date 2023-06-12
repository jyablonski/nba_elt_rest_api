from datetime import datetime, timedelta
from typing import List

from fastapi import APIRouter, Depends, HTTPException, Form, Request
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.crud import store_bet_predictions
from src.database import get_db
from src.models import Predictions, UserPastPredictions, UserPredictions, Users
from src.security import get_current_user_from_token
from src.utils import templates

router = APIRouter()


@router.get("/bets", response_class=HTMLResponse)
async def get_user_bets_page(
    request: Request,
    username: str = Depends(get_current_user_from_token),
    db: Session = Depends(get_db),
):
    if username is None:
        return templates.TemplateResponse("404.html", {"request": request},)

    local_datetime = (datetime.utcnow() - timedelta(hours=5)).date()

    user_predictions = (
        db.query(UserPredictions)
        .filter(UserPredictions.username == username)
        .filter(UserPredictions.game_date == local_datetime)
    )
    user_predictions_count = user_predictions.count()
    user_predictions_results = user_predictions.cte("user_predictions")

    games_today_count = (
        db.query(Predictions).filter(Predictions.proper_date == local_datetime)
    ).count()

    # variable to populate element of the UI
    if user_predictions_count >= games_today_count:
        is_games_left = 0
    else:
        is_games_left = 1

    # this logic returns only the unselected games from today's date for this user
    check_todays_predictions = (
        db.query(Predictions)
        .filter(Predictions.proper_date == local_datetime)
        .join(
            user_predictions_results,
            (Predictions.home_team == user_predictions_results.c.home_team),
            isouter=True,
        )
        .filter(user_predictions_results.c.game_date == None)
    )

    return templates.TemplateResponse(
        "bets.html",
        {
            "request": request,
            "games_today": check_todays_predictions,
            "is_games_left": is_games_left,
            "username": username,
        },
    )


@router.post("/bets")
def store_user_bets_predictions_from_ui(
    request: Request,
    username: str = Depends(get_current_user_from_token),
    bet_predictions: List[str] = Form(...),
    bet_amounts: List[int] = Form(...),
    db: Session = Depends(get_db),
):
    username_check = (db.query(Users).filter(Users.username == username)).first()

    local_datetime = (datetime.utcnow() - timedelta(hours=5)).date()

    if username_check is None:
        raise HTTPException(
            status_code=403, detail="This User does not exist.",
        )

    # this logic checks if every game from today has already been selected or not
    # by the user, and then stores it as a cte for use in a query later
    user_predictions = (
        db.query(UserPredictions)
        .filter(UserPredictions.username == username)
        .filter(UserPredictions.game_date == local_datetime)
    )
    user_predictions_count = user_predictions.count()
    user_predictions_results = user_predictions.cte("user_predictions")

    games_today_count = (
        db.query(Predictions).filter(Predictions.proper_date == local_datetime)
    ).count()

    if user_predictions_count >= games_today_count:
        raise HTTPException(
            status_code=403,
            detail="All Games for Today have been predicted already by this user!",
        )

    check_todays_predictions = (
        db.query(Predictions)
        .filter(Predictions.proper_date == local_datetime)
        .join(
            user_predictions_results,
            (Predictions.home_team == user_predictions_results.c.home_team),
            isouter=True,
        )
        .filter(user_predictions_results.c.game_date == None)
    ).cte("user_remaining_games")

    predictions_list = []

    for prediction, bet_amount in zip(bet_predictions, bet_amounts):
        print(f"heyo bet amount is {bet_amount}")
        result = (
            db.query(check_todays_predictions)
            .filter(
                (check_todays_predictions.c.home_team == prediction)
                | (check_todays_predictions.c.away_team == prediction)
            )
            .first()
        )
        if result is not None:
            result = result._asdict()
            result["selected_winner"] = prediction
            result["username"] = username
            result["bet_amount"] = bet_amount
            predictions_list.append(result)

    store_bet_predictions(db, predictions_list)

    return templates.TemplateResponse(
        "bets.html", {"request": request, "username": username,},
    )
