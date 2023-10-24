from datetime import date, datetime, timezone
from typing import Optional


from pydantic import BaseModel

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

    class Config:
        from_attributes = True


class ScorersBase(BaseModel):
    player: str
    team: str
    full_team: str
    season_avg_ppg: float
    playoffs_avg_ppg: Optional[float]
    season_ts_percent: Optional[float]
    playoffs_ts_percent: Optional[float]
    games_played: int
    playoffs_games_played: Optional[int]
    ppg_rank: int
    top20_scorers: str
    player_mvp_calc_adj: float
    games_missed: int
    penalized_games_missed: int
    top5_candidates: str
    mvp_rank: int

    class Config:
        from_attributes = True


class TeamRatingsBase(BaseModel):
    team: str
    team_acronym: str
    w: int
    l: int  # noqa: E741
    ortg: float
    drtg: float
    nrtg: float
    team_logo: str
    nrtg_rank: str
    drtg_rank: str
    ortg_rank: str

    class Config:
        from_attributes = True


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

    class Config:
        from_attributes = True


class RedditBase(BaseModel):
    scrape_date: date
    author: str
    comment: str
    flair: Optional[str]
    score: int
    url: str
    compound: float
    neg: float
    neu: float
    pos: float

    class Config:
        from_attributes = True


class InjuriesBase(BaseModel):
    player: Optional[str] = None
    team_acronym: Optional[str] = None
    team: Optional[str] = None
    date: Optional[str] = None
    status: Optional[str] = None
    injury: Optional[str] = None
    description: Optional[str] = None
    total_injuries: Optional[int] = None
    team_active_injuries: Optional[int] = None
    team_active_protocols: Optional[int] = None

    class Config:
        from_attributes = True


class GameTypesBase(BaseModel):
    game_type: str
    type: str
    n: int
    explanation: str

    class Config:
        from_attributes = True


class PlayerBase(BaseModel):
    name: str
    team: str
    ppg: float

    class Config:
        from_attributes = True


class TeamOriginalBase(BaseModel):
    name: str
    color: str
    players: str

    class Config:
        from_attributes = True


class FeedbackBase(BaseModel):
    feedback: str
    time: datetime

    class Config:
        from_attributes = True


class ScheduleBase(BaseModel):
    date: date
    day: str
    start_time: str
    avg_team_rank: int
    home_team: str
    home_moneyline_raw: Optional[int] = None
    away_team: str
    away_moneyline_raw: Optional[int] = None

    class Config:
        from_attributes = True


class PredictionsBase(BaseModel):
    proper_date: date
    home_team: str
    home_team_odds: int
    home_team_predicted_win_pct: float
    away_team: str
    away_team_odds: int
    away_team_predicted_win_pct: float

    class Config:
        from_attributes = True


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

    class Config:
        from_attributes = True


class TransactionsBase(BaseModel):
    date: date
    transaction: str

    class Config:
        from_attributes = True


class UserBase(BaseModel):
    username: str
    password: str
    email: Optional[str]
    created_at: datetime = datetime.now(timezone.utc)

    class Config:
        from_attributes = True


class UserCreate(UserBase):
    pass


class Token(BaseModel):
    access_token: str
    token_type: str
