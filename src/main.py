from datetime import datetime
import os
from typing import List, Union

from fastapi import Depends, FastAPI, HTTPException, Request, Form
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from mangum import Mangum
from opentelemetry import trace
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from sqlalchemy.orm import Session

from . import crud, models, schemas
from .database import engine, get_db
from .utils import team_acronyms

provider = TracerProvider()
processor = BatchSpanProcessor(OTLPSpanExporter())
provider.add_span_processor(processor)
trace.set_tracer_provider(provider)
tracer = trace.get_tracer(__name__)

templates = Jinja2Templates(directory="static")
models.Base.metadata.create_all(bind=engine)

app = FastAPI()
FastAPIInstrumentor.instrument_app(app)
RequestsInstrumentor().instrument()
handler = Mangum(app)


@app.get("/", response_class=HTMLResponse)
def hello_world(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.get("/standings", response_model=List[schemas.StandingsBase])
def read_standings(db: Session = Depends(get_db)):
    standings = crud.get_standings(db)
    return standings


@app.get("/scorers", response_model=List[schemas.ScorersBase])
def read_scorers(skip: int = 0, db: Session = Depends(get_db)):
    scorers = crud.get_scorers(db, skip=skip)
    return scorers


@app.get("/team_ratings", response_model=List[schemas.TeamRatingsBase])
def read_team_ratings(db: Session = Depends(get_db)):
    team_ratings = crud.get_team_ratings(db)
    return team_ratings


@app.get("/team_ratings/{team}", response_model=schemas.TeamRatingsBase)
def read_team_ratings_team(team: str, db: Session = Depends(get_db)):
    team_ratings_team = crud.get_team_ratings_by_team(db, team=team.upper())
    if team not in team_acronyms:
        raise HTTPException(
            status_code=404,
            detail=f"Team not found; please use a Team Acronym: {team_acronyms}",
        )
    elif team_ratings_team is None:
        raise HTTPException(status_code=200, detail=f"No Team Ratings Data for {team}")
    else:
        return team_ratings_team


@app.get("/twitter_comments", response_model=List[schemas.TwitterBase])
def read_twitter_comments(
    skip: int = 0, limit: int = 250, db: Session = Depends(get_db)
):
    twitter_comments = crud.get_twitter_comments(db, skip=skip, limit=limit)
    return twitter_comments


@app.get("/reddit_comments", response_model=List[schemas.RedditBase])
def read_reddit_comments(
    skip: int = 0, limit: int = 250, db: Session = Depends(get_db)
):
    reddit_comments = crud.get_reddit_comments(db, skip=skip, limit=limit)
    return reddit_comments


@app.get("/injuries", response_model=List[schemas.InjuriesBase])
def read_injuries(skip: int = 0, limit: int = 250, db: Session = Depends(get_db)):
    injuries = crud.get_injuries(db, skip=skip, limit=limit)
    return injuries


@app.get("/injuries/{team}", response_model=schemas.InjuriesBase)
def read_team_ratings_team(team: str, db: Session = Depends(get_db)):
    injuries_team = crud.get_injuries_by_team(db, team=team.upper())

    if team.upper() not in team_acronyms:
        raise HTTPException(
            status_code=404,
            detail=f"Team not found; please use a Team Acronym: {team_acronyms}",
        )
    elif injuries_team is None:
        raise HTTPException(status_code=200, detail=f"No Injury Data for {team}")
    else:
        return injuries_team


@app.get("/game_types", response_model=List[schemas.GameTypesBase])
def read_game_types(db: Session = Depends(get_db)):
    game_types = crud.get_game_types(db)
    return game_types


@app.get("/feedback", response_class=HTMLResponse)
def form_get():
    return """<form method="post"> 
    <input type="text" style="font-size: 18pt; height: 50px; width:1000px;" name="user_feedback" value=""/> 
    <input type="submit" style="font-size: 12pt; height: 50px;"/> 
    </form>"""


@app.post("/feedback", response_model=schemas.FeedbackBase)
def post_feedback(user_feedback: str = Form(...), db: Session = Depends(get_db)):
    return crud.send_feedback(db, user_feedback)


@app.get("/schedule", response_model=List[schemas.ScheduleBase])
def read_schedule(db: Session = Depends(get_db)):
    schedule = crud.get_schedule(db)
    return schedule


@app.get("/predictions", response_model=List[schemas.PredictionsBase])
def read_predictions(db: Session = Depends(get_db)):
    predictions = crud.get_predictions(db)
    return predictions


@app.get("/transactions", response_model=List[schemas.TransactionsBase])
def read_transactions(db: Session = Depends(get_db)):
    transactions = crud.get_transactions(db)
    return transactions


@app.post("/users", response_model=schemas.UserBase, status_code=201)
async def create_users(
    create_user_request: schemas.UserCreate, db: Session = Depends(get_db)
):
    record_check = (
        db.query(models.Users)
        .filter(models.Users.username == create_user_request.username)
        .first()
    )

    if record_check:
        raise HTTPException(
            status_code=400,
            detail="Username already exists!  Please select another username.",
        )

    return crud.create_user(db, create_user_request)


@app.put("/users/{username}", response_model=schemas.UserBase)
async def update_user(
    update_user_request: schemas.UserBase, username: str, db: Session = Depends(get_db)
):
    user_record = (
        db.query(models.Users).filter(models.Users.username == username).first()
    )

    if not user_record:
        raise HTTPException(
            status_code=400,
            detail="Username doesn't exist!  Please select another username.",
        )

    return crud.update_user(db, user_record, update_user_request)


@app.delete("/users/{username}")
async def delete_user(
    delete_user_request: schemas.Authentication,
    username: str,
    db: Session = Depends(get_db),
):
    if not delete_user_request.api_key:
        raise HTTPException(
            status_code=401,
            detail="You need a valid API Key to perform this operation.",
        )

    if delete_user_request.api_key != os.environ.get("API_KEY"):
        raise HTTPException(
            status_code=403, detail="nuh uh you got the wrong auth mfer"
        )

    user_record = (
        db.query(models.Users).filter(models.Users.username == username).first()
    )

    if not user_record:
        raise HTTPException(
            status_code=400,
            detail="Username doesn't exist!  Please select another username.",
        )

    return crud.delete_user(db, user_record)


@app.get("/bets", response_class=HTMLResponse)
def get_bets_page(request: Request, db: Session = Depends(get_db)):
    # this logic checks if every game from today has already been acted upon or not
    jacobs_predictions = (
        db.query(models.JacobsPredictions)
        .filter(models.JacobsPredictions.game_date == datetime.utcnow().date())
        .count()
    )

    # this logic returns only the unselected games from today's date
    check_todays_predictions = (
        db.query(models.Predictions)
        .filter(models.Predictions.proper_date == datetime.utcnow().date())
        .outerjoin(
            models.JacobsPredictions,
            models.Predictions.home_team == models.JacobsPredictions.home_team,
        )
        .filter(models.JacobsPredictions.home_team == None)
    )

    return templates.TemplateResponse(
        "bets.html",
        {
            "request": request,
            "games_today": check_todays_predictions,  # [0]
            "jacobs_predictions": jacobs_predictions,
        },
    )


@app.post("/bets")
def store_bets_predictions_from_ui(
    bet_predictions: List[str] = Form(...), db: Session = Depends(get_db)
):
    predictions_list = []
    for prediction in bet_predictions:
        result = (
            db.query(models.Predictions)
            .filter(
                (models.Predictions.home_team == prediction)
                | (models.Predictions.away_team == prediction)
            )
            .first()
        )
        result.selected_winner = prediction
        predictions_list.append(result)

    return crud.store_bet_predictions(db, predictions_list)
