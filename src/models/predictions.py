from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
    Date,
    PrimaryKeyConstraint,
    TIMESTAMP,
)
from src.database import Base


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
