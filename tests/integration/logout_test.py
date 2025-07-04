def test_logout(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        "/v1/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    assert f"Welcome <b>{username}" in response.text
    assert response.status_code == 200
    assert "access_token" in client_fixture.cookies

    logout_response = client_fixture.post(
        "/v1/logout",
        follow_redirects=False,
    )
    assert logout_response.status_code == 302
    assert "access_token" not in client_fixture.cookies


def test_logout_no_user(client_fixture):
    response = client_fixture.post(
        "/v1/logout",
    )
    assert response.status_code == 200
    assert "User Login" in response.text
    assert "access_token" not in client_fixture.cookies
