def test_bet_form_user_prediction(client_fixture):
    username = "jyablonski"

    response = client_fixture.post(
        f"/bets",
        data={
            "username": username,
            "bet_predictions": ["Indiana Pacers", "Houston Rockets"],
        },
    )

    # this is to make test suite idempotent - this test either saves predictions and returns 200
    # or the test already ran, the predictions are already stored, and it returns 403.
    assert response.json()["detail"] == "Not authenticated"
    # assert response.status_code in (200, 403)

    # if response.status_code == 403:
    #     assert (
    #         response.json()["detail"]
    #         == "All Games for Today have been predicted already by this user!"
    #     )


def test_bets_form_incorrect_permissions(client_fixture):
    response = client_fixture.get(f"/bets",)

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


def test_past_bets_form_incorrect_permissions(client_fixture):
    response = client_fixture.get(f"/bets",)

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


# def test_bet_form_incorrect_permissions(client_fixture):
#     response = client_fixture.post(
#         "/login", data={"username": "jyablonski", "password": "password",},
#     )

#     assert response.json() == 'hi'

#     # assert response.status_code == 401
#     assert response.text == 'Not authenticated'
