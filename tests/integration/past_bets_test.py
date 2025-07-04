def test_get_past_bets_form_incorrect_permissions(client_fixture):
    response = client_fixture.get(
        "/past_bets",
        allow_redirects=False,
    )

    if response.status_code == 302:
        assert response.headers["Location"] == "/login"
    else:
        assert response.status_code == 401
        assert response.json()["detail"] == "Not authenticated"


def test_past_bets_form_get(client_fixture, admin_user):
    bets_response = client_fixture.get("/past_bets")

    assert bets_response.status_code == 200
    assert "jyablonski" in bets_response.text
    assert "Houston Rockets" in bets_response.text


def test_past_bets_form_post_csv_no_permissions(client_fixture):
    post_response = client_fixture.post(
        "/v1/past_bets",
        allow_redirects=False,
    )

    if post_response.status_code == 302:
        assert post_response.headers["Location"] == "/login"
    else:
        assert post_response.status_code == 401
        assert post_response.json()["detail"] == "Not authenticated"


def test_past_bets_form_post_csv(client_fixture, admin_user):
    bets_post_response = client_fixture.post("/v1/past_bets")

    assert bets_post_response.status_code == 200
    assert "username,game_date,home_team,home_team_odds," in bets_post_response.text
