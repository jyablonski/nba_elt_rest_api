from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
)
from src.database import Base


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
