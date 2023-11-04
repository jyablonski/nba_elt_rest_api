def test_schedule(client_fixture):
    response = client_fixture.get("/schedule")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["home_team"] == "Indiana Pacers"
    assert list(data[0].keys()) == [
        "game_date",
        "day",
        "start_time",
        "avg_team_rank",
        "home_team",
        "home_moneyline_raw",
        "away_team",
        "away_moneyline_raw",
    ]
