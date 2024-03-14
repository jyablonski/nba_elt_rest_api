import logging
import sys

# from opensearch_logger import OpenSearchHandler


def create_logger() -> logging.Logger:
    """
    Logger which writes to both stdout as well as an Opensearch Endpoint

    Args:
        None

    Returns:
        Logger
    """
    logger = logging.getLogger()

    # create formatters
    formatter = logging.Formatter(
        fmt="[%(levelname)s] %(asctime)s %(message)s", datefmt="%Y-%m-%d %I:%M:%S %p"
    )
    stream_handler = logging.StreamHandler(sys.stdout)
    stream_handler.setFormatter(formatter)

    # opensearch_handler = OpenSearchHandler(
    #     index_name=opensearch_index,
    #     hosts=[opensearch_endpoint],
    #     # http_auth=("admin", "admin"),
    #     http_compress=True,
    #     use_ssl=False,
    #     verify_certs=False,
    #     ssl_assert_hostname=False,
    #     ssl_show_warn=False,
    #     flush_frequency=9,
    # )
    logger.handlers = [stream_handler]
    logger.setLevel(logging.INFO)

    return logger


logger = create_logger()
