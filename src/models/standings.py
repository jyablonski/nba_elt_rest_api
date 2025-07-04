from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
)
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
