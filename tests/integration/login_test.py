def test_login(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    assert f"Welcome {username}" in response.text
    assert response.status_code == 200


def test_login_fail(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        "/login", data={"username": username, "password": "fake_fkn_password",},
    )

    assert response.status_code == 200
    assert "Incorrect Username or Password" in response.text
