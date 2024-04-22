from datetime import date, datetime, timezone

from pydantic import BaseModel, ConfigDict

# Pydantic models use the normal name: str schema for data types


class StandingsBase(BaseModel):
    rank: str
    team: str
    team_full: str
    conference: str
    wins: int
    losses: int
    games_played: int
    win_pct: float
    active_injuries: int
    active_protocols: int
    last_10: str

    model_config = ConfigDict(from_attributes=True)


class PlayerStatsBase(BaseModel):
    player: str
    season_type: str
    team: str
    full_team: str
    avg_ppg: float
    avg_ts_percent: float | None
    avg_mvp_score: float
    avg_plus_minus: float
    games_played: int
    ppg_rank: int
    scoring_category: str
    games_missed: int
    penalized_games_missed: int
    is_mvp_candidate: str
    mvp_rank: int

    model_config = ConfigDict(from_attributes=True)


class TeamRatingsBase(BaseModel):
    team: str
    team_acronym: str
    wins: int
    losses: int  # noqa: E741
    ortg: float
    drtg: float
    nrtg: float
    team_logo: str
    nrtg_rank: str
    drtg_rank: str
    ortg_rank: str

    model_config = ConfigDict(from_attributes=True)


class TwitterBase(BaseModel):
    scrape_ts: datetime
    username: str
    tweet: str
    url: str
    likes: int
    retweets: int
    compound: float
    neg: float
    neu: float
    pos: float

    model_config = ConfigDict(from_attributes=True)


class RedditBase(BaseModel):
    scrape_date: date
    author: str
    comment: str
    flair: str | None
    score: int
    url: str
    compound: float
    neg: float
    neu: float
    pos: float

    model_config = ConfigDict(from_attributes=True)


class InjuriesBase(BaseModel):
    player: str | None
    team_acronym: str | None = None
    injury_status: str | None = None
    injury: str | None = None
    injury_description: str | None = None
    scrape_date: date | None = None

    model_config = ConfigDict(from_attributes=True)


class GameTypesBase(BaseModel):
    game_type: str
    season_type: str
    n: int
    explanation: str

    model_config = ConfigDict(from_attributes=True)


class PlayerBase(BaseModel):
    name: str
    team: str
    ppg: float

    model_config = ConfigDict(from_attributes=True)


class TeamOriginalBase(BaseModel):
    name: str
    color: str
    players: str

    model_config = ConfigDict(from_attributes=True)


class FeedbackBase(BaseModel):
    feedback: str
    time: datetime

    model_config = ConfigDict(from_attributes=True)


class ScheduleBase(BaseModel):
    game_date: date
    day_name: str
    start_time: str
    avg_team_rank: int
    home_team: str
    home_moneyline_raw: int | None = None
    away_team: str
    away_moneyline_raw: int | None = None

    model_config = ConfigDict(from_attributes=True)


class PredictionsBase(BaseModel):
    game_date: date
    home_team: str
    home_team_odds: int
    home_team_predicted_win_pct: float
    away_team: str
    away_team_odds: int
    away_team_predicted_win_pct: float

    model_config = ConfigDict(from_attributes=True)


class UserPredictions(BaseModel):
    username: str
    game_date: str
    home_team: str
    home_team_odds: int
    home_team_predicted_win_pct: float
    away_team: str
    away_team_odds: int
    away_team_predicted_win_pct: float
    selected_winner: str
    created_at: datetime = datetime.now(timezone.utc)

    model_config = ConfigDict(from_attributes=True)


class TransactionsBase(BaseModel):
    date: date
    transaction: str

    model_config = ConfigDict(from_attributes=True)


class UserBase(BaseModel):
    username: str
    password: str
    email: str | None = None
    created_at: datetime = datetime.now(timezone.utc)

    model_config = ConfigDict(from_attributes=True)


class UserCreate(UserBase):
    pass


class Token(BaseModel):
    access_token: str
    token_type: str


class HousingPredictionBase(BaseModel):
    state: str
    square_ft: int
    num_stories: int
    qol_index: float

    model_config = ConfigDict(from_attributes=True)


class PasswordResetRequest(BaseModel):
    email: str


class PasswordReset(BaseModel):
    token: str
    new_password: str


class HealthCheck(BaseModel):
    """Response model to validate and return when performing a health check."""

    status: str = "OK"
