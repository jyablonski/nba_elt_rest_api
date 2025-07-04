from sqlalchemy import (
    Column,
    Integer,
    String,
    PrimaryKeyConstraint,
    TIMESTAMP,
)

from src.database import Base


class Incidents(Base):
    __tablename__ = "incidents"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    incident_name = Column(String, nullable=False)
    incident_description = Column(String, nullable=False)
    is_active = Column(Integer, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    modified_at = Column(TIMESTAMP, nullable=False)
