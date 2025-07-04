from sqlalchemy.orm import Session

from src.models.reddit_comments import RedditComments


def get_reddit_comments(
    db: Session, page: int = 1, limit: int = 250, text_filter: str | None = None
):
    offset = (page - 1) * limit
    query = db.query(RedditComments)

    if text_filter:
        query = (
            query.filter(RedditComments.comment.ilike(f"% {text_filter} %"))
            .offset(offset)
            .limit(limit)
        )
    else:
        query = query.offset(offset).limit(limit)

    return query.all()
