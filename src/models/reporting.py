from sqlalchemy import (
    Column,
    Integer,
    String,
    PrimaryKeyConstraint,
    TIMESTAMP,
)

from src.database import Base


class Reports(Base):
    __tablename__ = "reports"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    report_name = Column(String, nullable=False)
    is_active = Column(Integer, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    modified_at = Column(TIMESTAMP, nullable=False)
