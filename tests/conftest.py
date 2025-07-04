from __future__ import annotations

import logging
import os

from fastapi.testclient import TestClient
from fastapi_cache import FastAPICache
from fastapi_cache.backends.redis import RedisBackend
import pytest
from redis import asyncio as aioredis

from src.database import load_yaml_with_env
from src.security import OAuth2PasswordBearerWithCookie
from src.server import app


@pytest.fixture(autouse=True)
def disable_logging():
    logging.disable(logging.ERROR)


@pytest.fixture(autouse=True)
def cache_setup():
    redis = aioredis.from_url(
        url=f"redis://:{os.environ.get('REDIS_PW')}@{os.environ.get('REDIS_HOST')}"
    )
    FastAPICache.init(RedisBackend(redis), prefix="fastapi-cache")


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


def login_user(client_fixture: TestClient, username: str, password: str = "password"):
    login_response = client_fixture.post(
        "/v1/login",
        data={
            "username": username,
            "password": password,
        },
    )
    return login_response


@pytest.fixture()
def consumer_user(client_fixture):
    return login_user(
        client_fixture=client_fixture, username="test", password="password"
    )


@pytest.fixture()
def admin_user(client_fixture):
    return login_user(
        client_fixture=client_fixture, username="test1", password="password"
    )


@pytest.fixture()
def jyablonski_user(client_fixture):
    return login_user(
        client_fixture=client_fixture, username="jyablonski", password="password"
    )
