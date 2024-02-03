import logging
import sys

# get logger
logger = logging.getLogger()

# create formatters
formatter = logging.Formatter(
    fmt="[%(levelname)s] %(asctime)s %(message)s", datefmt="%Y-%m-%d %I:%M:%S %p"
)

# create handlers
# file_handler = logging.FileHandler("app.log")
stream_handler = logging.StreamHandler(sys.stdout)

# set formatters
# file_handler.setFormatter(formatter)
stream_handler.setFormatter(formatter)

logger.handlers = [stream_handler]

logger.setLevel(logging.INFO)
