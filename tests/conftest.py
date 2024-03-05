from __future__ import annotations

import os

from fastapi.testclient import TestClient
from fastapi_cache import FastAPICache
from fastapi_cache.backends.inmemory import InMemoryBackend
import pytest

from src.database import load_yaml_with_env
from src.security import OAuth2PasswordBearerWithCookie
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


@pytest.fixture()
def oauth2_password_bearer():
    oauth2 = OAuth2PasswordBearerWithCookie(
        tokenUrl="/token", scopes={"read": "Read access"}
    )
    return oauth2


@pytest.fixture()
def consumer_user(client_fixture):
    username = "test"

    login_response = client_fixture.post(  # noqa: F841
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    return login_response


@pytest.fixture()
def admin_user(client_fixture):
    username = "test1"

    login_response = client_fixture.post(  # noqa: F841
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    return login_response


@pytest.fixture()
def jyablonski_user(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(  # noqa: F841
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    return login_response
