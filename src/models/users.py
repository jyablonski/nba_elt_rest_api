from sqlalchemy import (
    Column,
    Integer,
    String,
    PrimaryKeyConstraint,
    TIMESTAMP,
)
from sqlalchemy.sql import func

from src.database import Base


class Users(Base):
    __tablename__ = "rest_api_users"
    __table_args__ = (PrimaryKeyConstraint("id"),)

    id = Column(Integer, nullable=False, autoincrement=True)
    username = Column(String, nullable=False)
    password = Column(String, nullable=False)
    email = Column(String, nullable=True)
    salt = Column(String, nullable=False)
    created_at = Column(TIMESTAMP, nullable=False, default=func.now())
    role = Column(String, nullable=False, default="Consumer")
    modified_at = Column(TIMESTAMP, nullable=False, default=func.now())
    timezone = Column(String, nullable=False, default="UTC")
