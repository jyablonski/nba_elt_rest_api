from sqlalchemy import (
    Column,
    Integer,
    String,
    Float,
    PrimaryKeyConstraint,
    TIMESTAMP,
)

from src.database import Base


class TwitterComments(Base):
    __tablename__ = "twitter_comments"
    __table_args__ = (PrimaryKeyConstraint("scrape_ts", "username", "tweet"),)

    scrape_ts = Column(TIMESTAMP, nullable=False)
    username = Column(String, nullable=False)
    tweet = Column(String, nullable=False)
    url = Column(String, nullable=False)
    likes = Column(Integer, nullable=False)
    retweets = Column(Integer, nullable=False)
    compound = Column(Float, nullable=False)
    neg = Column(Float, nullable=False)
    neu = Column(Float, nullable=False)
    pos = Column(Float, nullable=False)
