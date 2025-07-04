def test_league_transactions(client_fixture):
    response = client_fixture.get("/v1/league/transactions")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["transaction"] == "The Portland Trail Blazers signed Skylar Mays."
    assert list(data[0].keys()) == [
        "date",
        "transaction",
    ]
