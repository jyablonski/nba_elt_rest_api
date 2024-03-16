def test_get_bets_form_incorrect_permissions(client_fixture):
    response = client_fixture.get(
        "/bets",
        allow_redirects=False,
    )

    if response.status_code == 302:
        assert response.headers["Location"] == "/login"
    else:
        assert response.status_code == 401
        assert response.json()["detail"] == "Not authenticated"


def test_post_bets_form_incorrect_permissions(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        "/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
            "bet_amounts": [10, 20],
        },
        allow_redirects=False,
    )

    if response.status_code == 302:
        assert response.headers["Location"] == "/login"
    else:
        assert response.status_code == 401
        assert response.json()["detail"] == "Not authenticated"


def test_bets_form_get(client_fixture, jyablonski_user):
    username = "jyablonski"
    bets_response = client_fixture.get("/bets")

    assert bets_response.status_code == 200
    assert username in bets_response.text
    assert "Houston Rockets" in bets_response.text


def test_bets_form_post(client_fixture, jyablonski_user):
    username = "jyablonski"

    first_bets_response = client_fixture.post(
        "/bets",
        data={
            "username": username,
            "bet_predictions": [
                "Indiana Pacers",
                "Houston Rockets",
                "Golden State Warriors",
                "Dallas Mavericks",
                "Chicago Bulls",
                "Utah Jazz",
                "Washington Wizards",
                "Sacramento Kings",
            ],
            "bet_amounts": [10, 20, 30, 40, 50, 60, 70, 10],
        },
    )

    second_bets_response = client_fixture.post(
        "/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
            "bet_amounts": [10, 20],
        },
    )

    assert first_bets_response.status_code == 200
    assert username in first_bets_response.text
    assert "No Games to Predict" in first_bets_response.text

    assert second_bets_response.status_code == 403
    assert (
        second_bets_response.json()["detail"]
        == "All Games for Today have been predicted already by this user!"
    )
