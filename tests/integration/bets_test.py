def test_get_bets_form_incorrect_permissions(client_fixture):
    response = client_fixture.get(
        f"/bets",
    )

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


def test_post_bets_form_incorrect_permissions(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        f"/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
            "bet_amounts": [10, 20],
        },
    )

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


def test_bets_form_get(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

    bets_response = client_fixture.get("/bets")

    assert login_response.status_code == 200
    assert bets_response.status_code == 200
    assert username in bets_response.text
    assert "Houston Rockets" in bets_response.text


def test_bets_form_post(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login",
        data={
            "username": username,
            "password": "password",
        },
    )

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
            ],
            "bet_amounts": [10, 20, 30, 40, 50, 60],
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

    assert login_response.status_code == 200

    assert first_bets_response.status_code == 200
    assert username in first_bets_response.text
    assert "No Games to Predict" in first_bets_response.text

    assert second_bets_response.status_code == 403
    assert (
        second_bets_response.json()["detail"]
        == "All Games for Today have been predicted already by this user!"
    )
