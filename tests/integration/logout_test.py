def test_logout(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    assert f"Welcome <b>{username}" in response.text
    assert response.status_code == 200

    logout_response = client_fixture.post(
        "/logout",
        follow_redirects=False,
    )
    assert logout_response.status_code == 302


def test_logout_no_user(client_fixture):
    response = client_fixture.post(
        "/logout",
    )
    assert response.status_code == 200
    assert "User Login" in response.text
