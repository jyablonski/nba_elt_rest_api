import pytest
from fastapi import HTTPException, status


class MockRequest:
    def __init__(self, cookies=None, url="/"):
        self.cookies = cookies or {}
        self.url = url


@pytest.mark.asyncio()
async def test_oauth2_password_bearer_with_cookie_valid_token(oauth2_password_bearer):
    request = MockRequest(cookies={"access_token": "Bearer valid_token"})
    result = await oauth2_password_bearer(request)
    assert result == "valid_token"


@pytest.mark.asyncio()
async def test_oauth2_password_bearer_with_cookie_invalid_token(oauth2_password_bearer):
    request = MockRequest(cookies={"access_token": "InvalidToken", "url": "/some_path"})

    with pytest.raises(HTTPException) as exc_info:
        await oauth2_password_bearer(request)

    assert exc_info.value.status_code == status.HTTP_302_FOUND
    assert exc_info.value.headers["Location"] == "/login"


@pytest.mark.asyncio()
async def test_oauth2_password_bearer_with_cookie_no_token(oauth2_password_bearer):
    request = MockRequest(url="/some_path")
    with pytest.raises(HTTPException) as exc_info:
        await oauth2_password_bearer(request)

    assert exc_info.value.status_code == status.HTTP_302_FOUND
    assert exc_info.value.headers["Location"] == "/login"


@pytest.mark.asyncio()
async def test_oauth2_password_bearer_with_cookie_login_path(oauth2_password_bearer):
    request = MockRequest(url="/login", cookies={"access_token": "Bearer valid_token"})
    result = await oauth2_password_bearer(request)
    assert result == "valid_token"
