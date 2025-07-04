from sqlalchemy import (
    Column,
    Integer,
    String,
    PrimaryKeyConstraint,
    TIMESTAMP,
)

from src.database import Base


class FeatureFlags(Base):
    __tablename__ = "feature_flags"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    flag = Column(String, nullable=False)
    is_enabled = Column(Integer, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False)
    modified_at = Column(TIMESTAMP, nullable=False)
