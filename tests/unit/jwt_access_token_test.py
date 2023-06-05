from datetime import timedelta
import os

from fastapi import HTTPException, status
from jose import jwt
import pytest

from src.security import create_access_token


def test_generate_access_token():
    username = "jyablonski"
    access_token_expires = timedelta(minutes=60)

    access_token = create_access_token(
        data={"sub": username}, expires_delta=access_token_expires
    )

    # jwt tokens have 3 separate "blocks", separated by 2 periods
    assert access_token.count(".") == 2
    assert len(access_token) == 131


def test_decode_access_token():
    username = "big_stupid_jwt_user"
    access_token_expires = timedelta(minutes=60)

    access_token = create_access_token(
        data={"sub": username}, expires_delta=access_token_expires
    )

    payload = jwt.decode(access_token, os.environ.get("API_KEY"), algorithms=["HS256"])
    jwt_username = payload.get("sub")

    assert jwt_username == username
