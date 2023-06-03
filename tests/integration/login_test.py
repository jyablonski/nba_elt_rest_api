def test_login(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    assert f"Welcome {username}" in response.text
    assert response.status_code == 200


def test_login_fail(client_fixture):
    response = client_fixture.post(
        "/login", data={"username": "jyablonski", "password": "bad_token",},
    )

    assert "Incorrect Username or Password" in response.text
