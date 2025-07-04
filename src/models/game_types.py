from sqlalchemy import (
    Column,
    Integer,
    String,
    PrimaryKeyConstraint,
)
from src.database import Base


class GameTypes(Base):
    __tablename__ = "game_types"
    __table_args__ = (PrimaryKeyConstraint("game_type", "season_type"),)

    game_type = Column(String, nullable=False)
    season_type = Column(String, nullable=False)
    n = Column(Integer, nullable=False)
    explanation = Column(String, nullable=False)


class TeamGameTypes(Base):
    __tablename__ = "team_game_types"
    __table_args__ = (PrimaryKeyConstraint("team", "game_type", "season_type"),)

    team = Column(String, nullable=False)
    game_type = Column(String, nullable=False)
    season_type = Column(String, nullable=False)
    n = Column(Integer, nullable=False)
    explanation = Column(String, nullable=False)
