from datetime import timedelta

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
