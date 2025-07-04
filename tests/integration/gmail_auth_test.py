from unittest.mock import patch, AsyncMock


@patch("src.routers.v1.gmail_auth.gmail_oauth")
def test_login_google(mock_gmail_oauth, client_fixture):
    mock_redirect_url = "http://localhost:8080/v1/google_auth"

    async def mocked_authorize_redirect(request, redirect_uri):
        return mock_redirect_url

    mock_gmail_oauth.google.authorize_redirect = AsyncMock(
        side_effect=mocked_authorize_redirect
    )

    response = client_fixture.get("/v1/login/google")
    assert response.status_code == 200
    assert response.text == f'"{mock_redirect_url}"'


@patch("src.routers.v1.gmail_auth.gmail_oauth")
def test_auth_google(mock_gmail_oauth, client_fixture):
    async def mocked_authorize_access_token(request):
        return {"userinfo": {"email": "test@gmail.com", "email_verified": True}}

    mock_gmail_oauth.google.authorize_access_token = AsyncMock(
        side_effect=mocked_authorize_access_token
    )

    response = client_fixture.get("/v1/auth_google", allow_redirects=False)

    assert response.status_code == 307
    assert "access_token" in response.cookies
