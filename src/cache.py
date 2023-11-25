from typing import Any, Callable
import hashlib

from fastapi import Request, Response


def key_builder_no_db(
    func: Callable[..., Any],
    namespace: str = "",
    *,
    request: Request | None = None,
    response: Response | None = None,
    args: tuple[Any, ...],
    kwargs: dict[str, Any],
) -> str:
    """Custom Key Builder for Caching to ignore DB"""

    kwargs.pop("db")

    # print(func.__module__) # name of the file
    # print(func.__name__)   # name of the function
    # print(args)            # none
    # print(kwargs)          # the endpoint in dict format
    cache_key = hashlib.md5(
        f"{func.__module__}:{func.__name__}:{args}:{kwargs}".encode()
    ).hexdigest()

    return f"{namespace}:{cache_key}"
