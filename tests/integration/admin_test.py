def test_admin_get_no_auth(client_fixture):
    response = client_fixture.get("/admin")

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


def test_admin_get_wrong_auth(client_fixture):
    username = "test1"

    login_response = client_fixture.post(  # noqa: F841
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    response = client_fixture.get("/admin")

    assert response.status_code == 401
    assert response.json()["detail"] == "You do not have the powa"


def test_admin_get_success(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(  # noqa: F841
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    response = client_fixture.get("/admin")

    assert response.status_code == 200
    assert "Admin Page" in response.text
