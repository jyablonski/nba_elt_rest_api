import os

from fastapi.testclient import TestClient
import pytest

from src.database import load_yaml_with_env
from src.server import app


@pytest.fixture()
def client_fixture():
    os.environ["API_KEY"] = "aaaa"
    client = TestClient(app)

    yield client


@pytest.fixture()
def config_fixture():
    os.environ["ENV_TYPE"] = "TEST"
    os.environ["bababooiee"] = "aaaaa"
    os.environ["RDS_USER"] = "jacob"
    os.environ["sigh"] = "zzzzz"
    config = load_yaml_with_env(f"tests/fixtures/config.yaml")

    return config
