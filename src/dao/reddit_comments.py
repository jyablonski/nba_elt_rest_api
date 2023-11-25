from sqlalchemy.orm import Session

from src.models import RedditComments


def get_reddit_comments(
    db: Session, skip: int = 0, limit: int = 250, text_filter: str | None = None
):
    query = db.query(RedditComments)

    if text_filter:
        query = (
            query.filter(RedditComments.comment.ilike(f"%{text_filter}%"))
            .offset(skip)
            .limit(limit)
        )
    else:
        query = query.offset(skip).limit(limit)

    return query.all()
