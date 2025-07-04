def test_league_predictions(client_fixture):
    response = client_fixture.get("/v1/league/predictions")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 8
    assert data[0]["home_team"] == "Indiana Pacers"
    assert list(data[0].keys()) == [
        "game_date",
        "home_team",
        "home_team_odds",
        "home_team_predicted_win_pct",
        "away_team",
        "away_team_odds",
        "away_team_predicted_win_pct",
    ]
