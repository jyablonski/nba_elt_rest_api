def test_get_bets_form_incorrect_permissions(client_fixture):
    response = client_fixture.get(f"/bets",)

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


def test_post_bets_form_incorrect_permissions(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        f"/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
        },
    )

    assert response.json()["detail"] == "Not authenticated"


def test_past_bets_form_get(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    bets_response = client_fixture.get("/bets")

    assert username in bets_response.text
    assert "Houston Rockets" in bets_response.text


def test_past_bets_form_post(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    first_bets_response = client_fixture.post(
        "/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
        },
    )

    second_bets_response = client_fixture.post(
        "/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
        },
    )

    print(first_bets_response)
    assert username in first_bets_response.text
    assert "No Games to Predict" in first_bets_response.text

    assert (
        second_bets_response.json()["detail"]
        == "All Games for Today have been predicted already by this user!"
    )
