from datetime import datetime, timedelta
import os

from jose import jwt

from src.security import create_access_token

# this is base64 encoded
# eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXSD3.eyJzdWIiOiJqeWFibG9uc2tpIiwiZXhwIjoxNjg2ATUyMTIwfQ.7S3zquBmNJD5s2d7i3_zbxjJFLa79HVjx75GFh9R92s

# then when u decode it, this is what's inside:
# {'sub': 'jyablonski', 'exp': 1686152120}


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
    jwt_username = payload["sub"]
    jwt_expiration = payload["exp"]

    jwt_expiration = datetime.fromtimestamp(jwt_expiration)

    assert jwt_username == username
    assert (datetime.now() + timedelta(minutes=60)) > jwt_expiration
