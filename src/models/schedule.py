from sqlalchemy import (
    Column,
    Integer,
    String,
    Date,
    PrimaryKeyConstraint,
)

from src.database import Base


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
