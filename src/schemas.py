from datetime import date, datetime, timezone
from typing import Optional, Union

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
    win_pct: str
    active_injuries: int
    active_protocols: int
    last_10: str

    class Config:
        orm_mode = True


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
    mvp_rank: str

    class Config:
        orm_mode = True


class TeamRatingsBase(BaseModel):
    team: str
    team_acronym: str
    w: int
    l: int
    ortg: float
    drtg: float
    nrtg: float
    team_logo: str
    nrtg_rank: str
    drtg_rank: str
    ortg_rank: str

    class Config:
        orm_mode = True


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
        orm_mode = True


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
        orm_mode = True


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
        orm_mode = True


class GameTypesBase(BaseModel):
    game_type: str
    type: str
    n: int
    explanation: str

    class Config:
        orm_mode = True


class PlayerBase(BaseModel):
    name: str
    team: str
    ppg: float

    class Config:
        orm_mode = True


class TeamOriginalBase(BaseModel):
    name: str
    color: str
    players: str

    class Config:
        orm_mode = True

class FeedbackBase(BaseModel):
    feedback: str
    time: datetime

    class Config:
        orm_mode = True
