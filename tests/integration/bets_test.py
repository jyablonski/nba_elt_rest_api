def test_bet_form_user_prediction(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        f"/users/{username}/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
        },
    )

    assert response.status_code == 200

def test_bet_form_no_user(client_fixture):
    username = "big_faker_user"

    response = client_fixture.post(
        f"/users/{username}/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
        },
    )

    assert response.json()['detail'] == "This User does not exist."
    assert response.status_code == 403