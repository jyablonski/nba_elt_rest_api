from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
    PrimaryKeyConstraint,
)

from src.database import Base


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
