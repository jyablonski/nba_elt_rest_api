import logging
import sys


def create_logger():
    logger = logging.getLogger()

    # create formatters
    formatter = logging.Formatter(
        fmt="[%(levelname)s] %(asctime)s %(message)s", datefmt="%Y-%m-%d %I:%M:%S %p"
    )
    stream_handler = logging.StreamHandler(sys.stdout)
    stream_handler.setFormatter(formatter)
    logger.handlers = [stream_handler]
    logger.setLevel(logging.INFO)

    return logger


logger = create_logger()
