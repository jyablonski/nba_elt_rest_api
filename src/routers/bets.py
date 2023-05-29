from datetime import datetime
from typing import Annotated, List

from fastapi import APIRouter, Depends, HTTPException, Form, Request
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.crud import store_bet_predictions
from src.database import get_db
from src.models import Predictions, UserPastPredictions, UserPredictions, Users
from src.security import verify_username
from src.utils import templates

router = APIRouter()


@router.get("/users/{username}/bets", response_class=HTMLResponse)
async def get_user_bets_page(
    request: Request,
    username: Annotated[str, Depends(verify_username)],
    db: Session = Depends(get_db),
):

    if username is None:
        return templates.TemplateResponse("404.html", {"request": request},)

    user_predictions = (
        db.query(UserPredictions)
        .filter(UserPredictions.username == username)
        .filter(UserPredictions.game_date == datetime.utcnow().date())
    )
    user_predictions_count = user_predictions.count()
    user_predictions_results = user_predictions.cte("user_predictions")

    games_today_count = (
        db.query(Predictions).filter(
            Predictions.proper_date == datetime.utcnow().date()
        )
    ).count()

    # variable to populate element of the UI
    if user_predictions_count >= games_today_count:
        is_games_left = 0
    else:
        is_games_left = 1

    # this logic returns only the unselected games from today's date for this user
    check_todays_predictions = (
        db.query(Predictions)
        .filter(Predictions.proper_date == datetime.utcnow().date())
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


@router.post("/users/{username}/bets")
def store_user_bets_predictions_from_ui(
    request: Request,
    username: str,
    bet_predictions: List[str] = Form(...),
    db: Session = Depends(get_db),
):
    username_check = (db.query(Users).filter(Users.username == username)).first()

    if username_check is None:
        raise HTTPException(
            status_code=403, detail="This User does not exist.",
        )

    # this logic checks if every game from today has already been selected or not
    # by the user, and then stores it as a cte for use in a query later
    user_predictions = (
        db.query(UserPredictions)
        .filter(UserPredictions.username == username)
        .filter(UserPredictions.game_date == datetime.utcnow().date())
    )
    user_predictions_count = user_predictions.count()
    user_predictions_results = user_predictions.cte("user_predictions")

    games_today_count = (
        db.query(Predictions).filter(
            Predictions.proper_date == datetime.utcnow().date()
        )
    ).count()

    if user_predictions_count >= games_today_count:
        raise HTTPException(
            status_code=403,
            detail="All Games for Today have been predicted already by this user!",
        )

    check_todays_predictions = (
        db.query(Predictions)
        .filter(Predictions.proper_date == datetime.utcnow().date())
        .join(
            user_predictions_results,
            (Predictions.home_team == user_predictions_results.c.home_team),
            isouter=True,
        )
        .filter(user_predictions_results.c.game_date == None)
    ).cte("user_remaining_games")

    predictions_list = []
    for prediction in bet_predictions:
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
            predictions_list.append(result)

    store_bet_predictions(db, predictions_list)

    return templates.TemplateResponse(
        "bets.html", {"request": request, "username": username,},
    )


@router.get("/users/{username}/past_bets", response_class=HTMLResponse)
def get_user_past_bets_page(
    request: Request,
    username: Annotated[str, Depends(verify_username)],
    db: Session = Depends(get_db),
):

    # this logic checks if every game from today has already been selected or not
    # by the user, and then stores it as a cte for use in a query later
    user_past_predictions = db.query(UserPastPredictions).filter(
        UserPastPredictions.username == username
    )

    return templates.TemplateResponse(
        "past_bets.html",
        {
            "request": request,
            "past_predictions": user_past_predictions,
            "username": username,
        },
    )
