import os

from fastapi import HTTPException
import pytest

from src.security import api_key_auth


def test_api_key_auth_error():
    with pytest.raises(HTTPException):
        os.environ["API_KEY"] = "aaaa"
        api_key_auth(api_key="fake_key_dude")
