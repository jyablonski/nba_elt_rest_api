def test_login_get(client_fixture):
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
    assert "access_token" in client_fixture.cookies


def test_login_fail(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        "/login",
        data={
            "username": username,
            "password": "fake_fkn_password",
        },
    )

    assert response.status_code == 200
    assert "Incorrect Username or Password" in response.text
    assert "access_token" not in client_fixture.cookies


def test_login_get_with_no_token(client_fixture):
    response = client_fixture.get("/login")

    assert "User Login" in response.text
    assert response.status_code == 200


def test_login_get_with_token(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    get_response = client_fixture.get("/login")

    assert response.status_code == 200
    assert f"Welcome <b>{username}" in get_response.text
    assert get_response.status_code == 200
    assert "access_token" in client_fixture.cookies


def test_create_user_get(client_fixture):
    response = client_fixture.get("/login/create_user")

    assert "Create a User" in response.text
    assert response.status_code == 200
