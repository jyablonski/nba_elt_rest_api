def test_team_events_get_no_auth(client_fixture):
    response = client_fixture.get(
        "/admin/team_events",
        allow_redirects=False,
    )

    if response.status_code == 302:
        assert response.headers["Location"] == "/login"
    else:
        assert response.status_code == 401
        assert response.json()["detail"] == "Not authenticated"


def test_team_events_get_wrong_auth(client_fixture, consumer_user):
    response = client_fixture.get("/admin/team_events")

    assert response.status_code == 403
    assert response.json()["detail"] == "You do not have the powa"


def test_team_events_get_success(client_fixture, admin_user):
    response = client_fixture.get("/admin/team_events")

    assert response.status_code == 200
    assert "Events Page" in response.text


def test_team_events_create_wrong_auth(client_fixture, consumer_user):
    response = client_fixture.post(
        "/v1/admin/team_events/create",
        data={
            "selected_team": [
                "GSW",
            ],
            "event_form": [
                "Test Event",
            ],
            "event_date_form": ["2024-05-01"],
        },
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 403
    assert response.json()["detail"] == "You do not have the powa"


# i've just begun
def test_team_events_post_success(client_fixture, admin_user):
    response = client_fixture.post(
        "/v1/admin/team_events/create",
        data={
            "selected_team": [
                "GSW",
            ],
            "event_form": [
                "Test Event",
            ],
            "event_date_form": ["2024-05-01"],
        },
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 200
    assert "Team Events Page" in response.text
