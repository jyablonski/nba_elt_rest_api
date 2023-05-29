import os

from fastapi.testclient import TestClient
import pytest

from src.main import app
from src.security import api_key_auth

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


@pytest.fixture
def client_fixture_no_auth():
    """
    Returns an API client which skips the authentication
    """

    def skip_auth():
        pass

    app.dependency_overrides[api_key_auth] = skip_auth
    return TestClient(app)
