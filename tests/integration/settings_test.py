def test_settings_get_no_auth(client_fixture):
    response = client_fixture.get("/settings", allow_redirects=False)

    if response.status_code == 302:
        assert response.headers["Location"] == "/login"
    else:
        assert response.status_code == 401
        assert response.json()["detail"] == "Not authenticated"


def test_settings_get_consumer_auth(client_fixture, consumer_user):
    username = "test"
    response = client_fixture.get("/settings")

    assert response.status_code == 200
    assert f"{username} Settings" in response.text


def test_settings_get_admin_auth(client_fixture, admin_user):
    username = "test1"
    response = client_fixture.get("/settings")

    assert response.status_code == 200
    assert f"{username} Settings" in response.text
