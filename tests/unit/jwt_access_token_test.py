from datetime import datetime, timedelta, timezone
import os

from jose import jwt

from src.security import create_access_token

# this is base64 encoded
# eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXSD3.eyJzdWIiOiJqeWFibG9uc2tpIiwiZXhwIjoxNjg2ATUyMTIwfQ.7S3zquBmNJD5s2d7i3_zbxjJFLa79HVjx75GFh9R92s

# then when u decode it, this is what's inside:
# {'sub': 'jyablonski', 'exp': 1686152120}


def test_generate_access_token():
    username = "jyablonski"
    access_token_expires = datetime.now(timezone.utc) + timedelta(days=30)

    access_token = create_access_token(
        data={"sub": username}, expires=access_token_expires
    )

    # jwt tokens have 3 separate "blocks", separated by 2 periods
    assert access_token.count(".") == 2
    assert len(access_token) == 131


def test_decode_access_token():
    username = "big_stupid_jwt_user"
    role = "Consumer"
    access_token_expires = datetime.now(timezone.utc) + timedelta(days=30)

    access_token = create_access_token(
        data={"sub": username, "role": role}, expires=access_token_expires
    )

    payload = jwt.decode(access_token, os.environ.get("API_KEY"), algorithms=["HS256"])
    jwt_username = payload["sub"]
    jwt_role = payload["role"]
    jwt_expiration = payload["exp"]

    jwt_expiration = datetime.fromtimestamp(jwt_expiration)

    # asserting that the username is the same, and that the jwt token lasts
    # longer than 30 days
    assert jwt_username == username
    assert jwt_role == role
    assert (datetime.now() + timedelta(days=31)) > jwt_expiration
    assert (datetime.now() + timedelta(days=29)) < jwt_expiration
