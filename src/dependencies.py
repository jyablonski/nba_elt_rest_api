import hashlib
from typing import Any, Callable, Generator


from fastapi import HTTPException, Path, Request, Response
from sqlalchemy.orm import Session
from src.database import SessionLocal

from src.utils import team_acronyms

# these are all functions that are used as dependencies in the FastAPI application
# to provide things like database sessions and validate team acronyms at runtime
# when handling requests


def validate_team_acronym(team: str = Path(...)) -> str:
    team = team.upper()
    if team not in team_acronyms:
        raise HTTPException(
            status_code=404,
            detail=f"Team not found; valid acronyms: {team_acronyms}",
        )
    return team


def get_db() -> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def key_builder_no_db(
    func: Callable[..., Any],
    namespace: str = "",
    *,
    request: Request | None = None,
    response: Response | None = None,
    args: tuple[Any, ...],
    kwargs: dict[str, Any],
) -> str:
    """
    Custom Key Builder for Caching to ignore DB

    Example:
    >>> @cache(expire=900, key_builder=key_builder_no_db)
    """

    kwargs.pop("db")

    # print(func.__module__) # name of the file
    # print(func.__name__)   # name of the function
    # print(args)            # none
    # print(kwargs)          # the endpoint in dict format
    cache_key = hashlib.md5(
        f"{func.__module__}:{func.__name__}:{args}:{kwargs}".encode()
    ).hexdigest()
    # logger.info("Cache Key: %s", cache_key)

    return f"{namespace}:{cache_key}"
