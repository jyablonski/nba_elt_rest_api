import os

from fastapi.testclient import TestClient
import pytest

from src.main import app

# def pytest_configure(config):
#     import src.main # NB this causes `src/core/__init__.py` to run
#     # set up any "aliases" (optional...)
#     import sys
#     sys.modules['core'] = sys.modules['src.core']


@pytest.fixture()
def client_fixture():
    os.environ["API_KEY"] = "aaaa"
    client = TestClient(app)

    yield client
