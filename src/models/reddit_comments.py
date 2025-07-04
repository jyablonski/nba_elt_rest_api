from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
    Date,
    PrimaryKeyConstraint,
)
from src.database import Base


class RedditComments(Base):
    __tablename__ = "reddit_comments"
    __table_args__ = (PrimaryKeyConstraint("scrape_date", "author", "comment"),)

    scrape_date = Column(Date, nullable=False)
    author = Column(String, nullable=False)
    comment = Column(String, nullable=False)
    flair = Column(String, nullable=True)
    score = Column(Integer, nullable=False)
    url = Column(String, nullable=False)
    compound = Column(Float, nullable=False)
    neg = Column(Float, nullable=False)
    neu = Column(Float, nullable=False)
    pos = Column(Float, nullable=False)
