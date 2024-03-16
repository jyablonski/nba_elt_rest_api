def test_admin_get_no_auth(client_fixture):
    response = client_fixture.get("/admin", allow_redirects=False)

    if response.status_code == 302:
        assert response.headers["Location"] == "/login"
    else:
        assert response.status_code == 401
        assert response.json()["detail"] == "Not authenticated"


def test_admin_get_wrong_auth(client_fixture, consumer_user):
    response = client_fixture.get("/admin")

    assert response.status_code == 403
    assert response.json()["detail"] == "You do not have the powa"


def test_admin_get_success(client_fixture, admin_user):
    response = client_fixture.get("/admin")

    assert response.status_code == 200
    assert "Admin Page" in response.text
