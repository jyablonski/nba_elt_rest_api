import os

from fastapi.testclient import TestClient
from fastapi_cache import FastAPICache
from fastapi_cache.backends.inmemory import InMemoryBackend
import pytest

from src.database import load_yaml_with_env
from src.server import app


@pytest.fixture(autouse=True)
def cache_setup():
    FastAPICache.init(InMemoryBackend())


@pytest.fixture()
def client_fixture():
    os.environ["API_KEY"] = "aaaa"
    client = TestClient(app)

    yield client


@pytest.fixture()
def config_fixture():
    os.environ["ENV_TYPE"] = "TEST"
    os.environ["RDS_HOST"] = "PYTEST"
    os.environ["RDS_USER"] = "jacob"
    os.environ["RDS_PASSWORD"] = "password"
    config = load_yaml_with_env("tests/fixtures/config.yaml")

    return config
