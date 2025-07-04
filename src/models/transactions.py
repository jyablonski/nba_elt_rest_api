from sqlalchemy import (
    Column,
    String,
    Date,
    PrimaryKeyConstraint,
)

from src.database import Base


class Transactions(Base):
    __tablename__ = "transactions"
    __table_args__ = (PrimaryKeyConstraint("date", "transaction"),)

    date = Column(Date, nullable=False)
    transaction = Column(String, nullable=False)
