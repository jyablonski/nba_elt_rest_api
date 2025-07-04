from sqlalchemy import (
    Column,
    String,
    Date,
    PrimaryKeyConstraint,
)

from src.database import Base


class Injuries(Base):
    __tablename__ = "injuries"
    __table_args__ = (PrimaryKeyConstraint("player", "injury", "injury_description"),)

    player = Column(String, nullable=True)
    team_acronym = Column(String, nullable=True)
    team = Column(String, nullable=True)
    injury_status = Column(String, nullable=True)
    injury = Column(String, nullable=True)
    injury_description = Column(String, nullable=True)
    scrape_date = Column(Date, nullable=True)
