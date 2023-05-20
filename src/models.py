from datetime import date, datetime

# from psycopg2 import Date
from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
    Date,
    PrimaryKeyConstraint,
    TIMESTAMP,
)

from .database import Base

# SqlAlchemy models use name = Column(String)
class Standings(Base):
    __tablename__ = "standings"

    rank: str = Column(String, unique=True, nullable=False)
    team: str = Column(String, unique=True, primary_key=True, nullable=False)
    team_full: str = Column(String, unique=True, nullable=False)
    conference: str = Column(String, nullable=False)
    wins: int = Column(Integer, nullable=False)
    losses: int = Column(Integer, nullable=False)
    games_played: int = Column(Integer, nullable=False)
    win_pct: str = Column(Float, nullable=False)
    active_injuries: int = Column(Integer, nullable=False)
    active_protocols: int = Column(Integer, nullable=False)
    last_10: str = Column(String, nullable=False)


class Scorers(Base):
    __tablename__ = "scorers"

    player: str = Column(String, unique=True, primary_key=True, nullable=False)
    team: str = Column(String, unique=True, nullable=False)
    full_team: str = Column(String, unique=True, nullable=False)
    season_avg_ppg: float = Column(Float)
    playoffs_avg_ppg: float = Column(Float, nullable=True)
    season_ts_percent: float = Column(Float)
    playoffs_ts_percent: float = Column(Float, nullable=True)
    games_played: int = Column(Integer)
    playoffs_games_played: int = Column(Integer, nullable=True)
    ppg_rank: int = Column(Integer)
    top20_scorers: str = Column(String)
    player_mvp_calc_adj: float = Column(Float)
    games_missed: int = Column(Integer)
    penalized_games_missed: int = Column(Integer)
    top5_candidates: str = Column(String)
    mvp_rank: str = Column(Integer)


class Team_Ratings(Base):
    __tablename__ = "team_ratings"

    team: str = Column(String, unique=True, primary_key=True, nullable=False)
    team_acronym: str = Column(String, unique=True, nullable=False)
    w: int = Column(Integer, nullable=False)
    l: int = Column(Integer, nullable=False)
    ortg: float = Column(Float, nullable=False)
    drtg: float = Column(Float, nullable=False)
    nrtg: float = Column(Float, nullable=False)
    team_logo: str = Column(String, nullable=False)
    nrtg_rank: str = Column(String, nullable=False)
    drtg_rank: str = Column(String, nullable=False)
    ortg_rank: str = Column(String, nullable=False)


class Twitter_Comments(Base):
    __tablename__ = "twitter_comments"
    __table_args__ = (PrimaryKeyConstraint("scrape_ts", "username", "tweet"),)

    scrape_ts: date = Column(TIMESTAMP, nullable=False)
    username: str = Column(String, nullable=False)
    tweet: str = Column(String, nullable=False)
    url: str = Column(String, nullable=False)
    likes: int = Column(Integer, nullable=False)
    retweets: int = Column(Integer, nullable=False)
    compound: float = Column(Float, nullable=False)
    neg: float = Column(Float, nullable=False)
    neu: float = Column(Float, nullable=False)
    pos: float = Column(Float, nullable=False)


class Reddit_Comments(Base):
    __tablename__ = "reddit_comments"
    __table_args__ = (PrimaryKeyConstraint("scrape_date", "author", "comment"),)

    scrape_date: date = Column(Date, nullable=False)
    author: str = Column(String, nullable=False)
    comment: str = Column(String, nullable=False)
    flair: str = Column(String, nullable=True)
    score: int = Column(Integer, nullable=False)
    url: str = Column(String, nullable=False)
    compound: float = Column(Float, nullable=False)
    neg: float = Column(Float, nullable=False)
    neu: float = Column(Float, nullable=False)
    pos: float = Column(Float, nullable=False)


class Injuries(Base):
    __tablename__ = "injuries"
    __table_args__ = (PrimaryKeyConstraint("player", "injury", "description"),)

    player: str = Column(String, nullable=True)
    team_acronym: str = Column(String, nullable=True)
    team: str = Column(String, nullable=True)
    date: str = Column(String, nullable=True)
    status: str = Column(String, nullable=True)
    injury: str = Column(String, nullable=True)
    description: str = Column(String, nullable=True)
    total_injuries: int = Column(Integer, nullable=True)
    team_active_injuries: int = Column(Integer, nullable=True)
    team_active_protocols: int = Column(Integer, nullable=True)


class Game_Types(Base):
    __tablename__ = "game_types"
    __table_args__ = (PrimaryKeyConstraint("game_type", "type"),)

    game_type: str = Column(String, nullable=False)
    type: str = Column(String, nullable=False)
    n: int = Column(Integer, nullable=False)
    explanation: str = Column(String, nullable=False)


class Feedback(Base):
    __tablename__ = "feedback"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id: int = Column(Integer, nullable=False, autoincrement=True)
    feedback: str = Column(String, nullable=False)
    time: datetime = Column(TIMESTAMP, nullable=False)


class Schedule(Base):
    __tablename__ = "schedule"
    __table_args__ = (PrimaryKeyConstraint("home_team", "date", "away_team"),)

    date: date = Column(Date, nullable=True)
    day: str = Column(String, nullable=True)
    start_time: str = Column(String, nullable=True)
    avg_team_rank: int = Column(Integer, nullable=True)
    home_team: str = Column(String, nullable=True)
    home_moneyline_raw: int = Column(Integer, nullable=True)
    away_team: str = Column(String, nullable=True)
    away_moneyline_raw: int = Column(Integer, nullable=True)


class Predictions(Base):
    __tablename__ = "nba_predictions"
    __table_args__ = (PrimaryKeyConstraint("home_team"),)

    proper_date: date = Column(Date, nullable=True)
    home_team: str = Column(String, nullable=False)
    home_team_odds: str = Column(String, nullable=False)
    home_team_predicted_win_pct: float = Column(Float, nullable=True)
    away_team: str = Column(String, nullable=True)
    away_team_odds: str = Column(String, nullable=False)
    away_team_predicted_win_pct: float = Column(Float, nullable=True)


class UserPredictions(Base):
    __tablename__ = "user_predictions"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id: int = Column(Integer, nullable=False, autoincrement=True)
    username: str = Column(String, nullable=False)
    game_date: date = Column(Date, nullable=True)
    home_team: str = Column(String, nullable=False)
    home_team_predicted_win_pct: float = Column(Float, nullable=True)
    away_team: str = Column(String, nullable=True)
    away_team_predicted_win_pct: float = Column(Float, nullable=True)
    selected_winner: str = Column(String, nullable=False)
    created_at: datetime = Column(TIMESTAMP, nullable=False)


class Transactions(Base):
    __tablename__ = "transactions"
    __table_args__ = (PrimaryKeyConstraint("date", "transaction"),)

    date: date = Column(Date, nullable=False)
    transaction: str = Column(String, nullable=False)


class Users(Base):
    __tablename__ = "rest_api_users"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id: int = Column(Integer, nullable=False, autoincrement=True)
    username: str = Column(String, nullable=False)
    password: str = Column(String, nullable=False)
    email: str = Column(String, nullable=True)
    created_at: datetime = Column(TIMESTAMP, nullable=False)
