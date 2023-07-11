def test_get_past_bets_form_incorrect_permissions(client_fixture):
    response = client_fixture.get(f"/past_bets",)

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


def test_past_bets_form_get(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    bets_response = client_fixture.get("/past_bets")

    assert login_response.status_code == 200
    assert bets_response.status_code == 200
    assert username in bets_response.text
    assert "Houston Rockets" in bets_response.text
