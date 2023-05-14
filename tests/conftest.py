import json
import os

from fastapi.testclient import TestClient
import pytest
import pytest_mock

from src.main import app, api_key_auth


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
