import logging

from opensearch_logger import OpenSearchHandler


def create_os_logger(index: str, host_endpoint: str):
    """
    Logger which writes to both STDOUT as well as an Opensearch Endpoint

    Args:
        es_index (str): The name of the Opensearch Index that logs will go to.
            It will be automatically created if it doesn't already exist.

        host_endpoint (str): The Endpoint of the Opensearch Cluster

    Returns:
        Opensearch Logger
    """
    logging.basicConfig(
        level=logging.INFO,
        format="[%(levelname)s] %(asctime)s %(message)s",
        datefmt="%Y-%m-%d %I:%M:%S %p",
    )
    handler = OpenSearchHandler(
        index_name=index,
        hosts=[f"{host_endpoint}"],
        # http_auth=("admin", "admin"),
        http_compress=True,
        use_ssl=False,
        verify_certs=False,
        ssl_assert_hostname=False,
        ssl_show_warn=False,
    )

    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)
    logger.addHandler(handler)

    return logger


# import os
# import random
# logger = create_os_logger(
#     index=f"rest_api_{os.environ.get('ENV_TYPE')}",
#     host_endpoint=f"http://localhost:9200"
# )

# logger = create_os_logger(
#     index=f"rest_api_{os.environ.get('ENV_TYPE')}",
#     host_endpoint=f"{os.environ.get('OPENSEARCH_ENDPOINT')}"
# )

# logger.info(f"TESTING {random.randint(1, 100)}")
# logger.warning(f"ooof at {random.randint(1, 100)}")
# logger.error(f"ERROR OOP {random.randint(1, 100)}")
