def test_standings(client_fixture):
    response = client_fixture.get("/standings")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["team"] == "MIL"
    assert list(data[0].keys()) == [
        "rank",
        "team",
        "team_full",
        "conference",
        "wins",
        "losses",
        "games_played",
        "win_pct",
        "active_injuries",
        "active_protocols",
        "last_10",
    ]
