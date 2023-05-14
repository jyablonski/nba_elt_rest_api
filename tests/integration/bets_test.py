def test_bet_form_user_prediction(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        f"/users/{username}/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
        },
    )

    # this is to make test suite idempotent - this test either saves predictions and returns 200
    # or the test already ran, the predictions are already stored, and it returns 403.
    assert response.status_code in (200, 403)

    if response.status_code == 403:
        assert response.json()['detail'] == "All Games for Today have been predicted already by this user!"

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