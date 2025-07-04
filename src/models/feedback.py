from sqlalchemy import (
    Column,
    Integer,
    String,
    PrimaryKeyConstraint,
    TIMESTAMP,
)

from src.database import Base


class Feedback(Base):
    __tablename__ = "feedback"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    feedback = Column(String, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    modified_at = Column(TIMESTAMP, nullable=False)
