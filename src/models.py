from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
    Date,
    PrimaryKeyConstraint,
    TIMESTAMP,
)
from sqlalchemy.sql import func

from src.database import Base


# SqlAlchemy models use name = Column(String)
class Standings(Base):
    __tablename__ = "standings"

    rank = Column(String, unique=True, nullable=False)
    team = Column(String, unique=True, primary_key=True, nullable=False)
    team_full = Column(String, unique=True, nullable=False)
    conference = Column(String, nullable=False)
    wins = Column(Integer, nullable=False)
    losses = Column(Integer, nullable=False)
    games_played = Column(Integer, nullable=False)
    win_pct = Column(Float, nullable=False)
    active_injuries = Column(Integer, nullable=False)
    active_protocols = Column(Integer, nullable=False)
    last_10 = Column(String, nullable=False)


class PlayerStats(Base):
    __tablename__ = "player_stats"
    __table_args__ = (PrimaryKeyConstraint("player", "season_type"),)

    player = Column(String, nullable=False)
    season_type = Column(String, nullable=False)
    team = Column(String, unique=True, nullable=False)
    full_team = Column(String, unique=True, nullable=False)
    avg_ppg = Column(Float)
    avg_ts_percent = Column(Float)
    avg_mvp_score = Column(Float)
    avg_plus_minus = Column(Float)
    games_played = Column(Integer)
    ppg_rank = Column(Integer)
    scoring_category = Column(String)
    games_missed = Column(Integer)
    penalized_games_missed = Column(Integer)
    is_mvp_candidate = Column(String)
    mvp_rank = Column(Integer)


class TeamRatings(Base):
    __tablename__ = "team_ratings"

    team = Column(String, unique=True, primary_key=True, nullable=False)
    team_acronym = Column(String, unique=True, nullable=False)
    wins = Column(Integer, nullable=False)
    losses = Column(Integer, nullable=False)  # noqa: E741
    ortg = Column(Float, nullable=False)
    drtg = Column(Float, nullable=False)
    nrtg = Column(Float, nullable=False)
    team_logo = Column(String, nullable=False)
    nrtg_rank = Column(String, nullable=False)
    drtg_rank = Column(String, nullable=False)
    ortg_rank = Column(String, nullable=False)


class TwitterComments(Base):
    __tablename__ = "twitter_comments"
    __table_args__ = (PrimaryKeyConstraint("scrape_ts", "username", "tweet"),)

    scrape_ts = Column(TIMESTAMP, nullable=False)
    username = Column(String, nullable=False)
    tweet = Column(String, nullable=False)
    url = Column(String, nullable=False)
    likes = Column(Integer, nullable=False)
    retweets = Column(Integer, nullable=False)
    compound = Column(Float, nullable=False)
    neg = Column(Float, nullable=False)
    neu = Column(Float, nullable=False)
    pos = Column(Float, nullable=False)


class RedditComments(Base):
    __tablename__ = "reddit_comments"
    __table_args__ = (PrimaryKeyConstraint("scrape_date", "author", "comment"),)

    scrape_date = Column(Date, nullable=False)
    author = Column(String, nullable=False)
    comment = Column(String, nullable=False)
    flair = Column(String, nullable=True)
    score = Column(Integer, nullable=False)
    url = Column(String, nullable=False)
    compound = Column(Float, nullable=False)
    neg = Column(Float, nullable=False)
    neu = Column(Float, nullable=False)
    pos = Column(Float, nullable=False)


class Injuries(Base):
    __tablename__ = "injuries"
    __table_args__ = (PrimaryKeyConstraint("player", "injury", "description"),)

    player = Column(String, nullable=True)
    team_acronym = Column(String, nullable=True)
    team = Column(String, nullable=True)
    date = Column(String, nullable=True)
    status = Column(String, nullable=True)
    injury = Column(String, nullable=True)
    description = Column(String, nullable=True)
    total_injuries = Column(Integer, nullable=True)
    team_active_injuries = Column(Integer, nullable=True)
    team_active_protocols = Column(Integer, nullable=True)


class GameTypes(Base):
    __tablename__ = "game_types"
    __table_args__ = (PrimaryKeyConstraint("game_type", "season_type"),)

    game_type = Column(String, nullable=False)
    season_type = Column(String, nullable=False)
    n = Column(Integer, nullable=False)
    explanation = Column(String, nullable=False)


class Feedback(Base):
    __tablename__ = "feedback"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    feedback = Column(String, nullable=False)
    time = Column(TIMESTAMP, nullable=False)


class Schedule(Base):
    __tablename__ = "schedule"
    __table_args__ = (PrimaryKeyConstraint("home_team", "game_date", "away_team"),)

    game_date = Column(Date, nullable=True)
    day_name = Column(String, nullable=True)
    start_time = Column(String, nullable=True)
    avg_team_rank = Column(Integer, nullable=True)
    home_team = Column(String, nullable=True)
    home_moneyline_raw = Column(Integer, nullable=True)
    away_team = Column(String, nullable=True)
    away_moneyline_raw = Column(Integer, nullable=True)


class Predictions(Base):
    __tablename__ = "nba_predictions"
    __table_args__ = (PrimaryKeyConstraint("home_team"),)

    game_date = Column(Date, nullable=True)
    home_team = Column(String, nullable=False)
    home_team_odds = Column(Integer, nullable=False)
    home_team_predicted_win_pct = Column(Float, nullable=True)
    away_team = Column(String, nullable=True)
    away_team_odds = Column(Integer, nullable=False)
    away_team_predicted_win_pct = Column(Float, nullable=True)


class UserPredictions(Base):
    __tablename__ = "user_predictions"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    username = Column(String, nullable=False)
    game_date = Column(Date, nullable=True)
    home_team = Column(String, nullable=False)
    home_team_odds = Column(Integer, nullable=False)
    home_team_predicted_win_pct = Column(Float, nullable=True)
    away_team = Column(String, nullable=True)
    away_team_odds = Column(Integer, nullable=False)
    away_team_predicted_win_pct = Column(Float, nullable=True)
    selected_winner = Column(String, nullable=False)
    bet_amount = Column(Integer, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)


class Transactions(Base):
    __tablename__ = "transactions"
    __table_args__ = (PrimaryKeyConstraint("date", "transaction"),)

    date = Column(Date, nullable=False)
    transaction = Column(String, nullable=False)


class Users(Base):
    __tablename__ = "rest_api_users"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    username = Column(String, nullable=False)
    password = Column(String, nullable=False)
    email = Column(String, nullable=True)
    salt = Column(String, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False, default=func.now())
    role = Column(String, nullable=False, default="Consumer")
    modified_at = Column(TIMESTAMP, nullable=False, default=func.now())
    timezone = Column(String, nullable=False, default="UTC")


class UserPastPredictions(Base):
    __tablename__ = "user_past_predictions"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    username = Column(String, nullable=False)
    game_date = Column(Date, nullable=True)
    home_team = Column(String, nullable=False)
    home_team_odds = Column(Integer, nullable=False)
    home_team_predicted_win_pct = Column(Float, nullable=True)
    away_team = Column(String, nullable=True)
    away_team_odds = Column(Integer, nullable=False)
    away_team_predicted_win_pct = Column(Float, nullable=True)
    selected_winner = Column(String, nullable=False)
    bet_amount = Column(Integer, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    actual_winner = Column(String, nullable=False)
    selected_winner_odds = Column(Integer, nullable=False)
    is_correct_prediction = Column(Integer, nullable=False)
    bet_profit = Column(Integer, nullable=False)


class FeatureFlags(Base):
    __tablename__ = "feature_flags"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    flag = Column(String, nullable=False)
    is_enabled = Column(Integer, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    modified_at = Column(TIMESTAMP, nullable=False)


class Incidents(Base):
    __tablename__ = "incidents"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    incident_name = Column(String, nullable=False)
    incident_description = Column(String, nullable=False)
    is_active = Column(Integer, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    modified_at = Column(TIMESTAMP, nullable=False)
