import time

from fastapi import Request

from src.logger import logger


async def log_middleware(request: Request, call_next):
    start = time.time()

    response = await call_next(request)

    process_time = time.time() - start
    log_dict = {
        "url": request.url.path,
        "method": request.method,
        "query_params": request.query_params,
        "process_time": process_time,
    }

    logger.info(log_dict, extra=log_dict)

    return response
