from sqlalchemy import (
    Column,
    Integer,
    String,
    Date,
    PrimaryKeyConstraint,
    TIMESTAMP,
)
from src.database import Base


class TeamEventContext(Base):
    __tablename__ = "team_event_context"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    team = Column(String, nullable=False)
    event = Column(String, nullable=False)
    event_date = Column(Date, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    modified_at = Column(TIMESTAMP, nullable=False)
