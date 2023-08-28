import os

from fastapi.testclient import TestClient
import pytest

from src.main import app


@pytest.fixture()
def client_fixture():
    os.environ["API_KEY"] = "aaaa"
    client = TestClient(app)

    yield client
