from typing import List

from fastapi import Depends, FastAPI, HTTPException, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
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
from .database import SessionLocal, engine

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

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


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
    team_ratings_team = crud.get_team_ratings_by_team(db, team=team)
    if team_ratings_team is None:
        raise HTTPException(
            status_code=404, detail="Team not found; please use a Team Acronym (in all Caps)"
        )
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
    injuries_team = crud.get_injuries_by_team(db, team=team)
    if injuries_team is None:
        raise HTTPException(
            status_code=404, detail="Team not found; please use a Team Acronym (in all Caps)"
        )
    return injuries_team


@app.get("/game_types", response_model=List[schemas.GameTypesBase])
def read_game_types(db: Session = Depends(get_db)):
    game_types = crud.get_game_types(db)
    return game_types
