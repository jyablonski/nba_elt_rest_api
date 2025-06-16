def test_player_stats(client_fixture):
    response = client_fixture.get("/players/stats")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["player"] == "Nikola Jokic"
    assert list(data[0].keys()) == [
        "player",
        "season_type",
        "team",
        "full_team",
        "avg_ppg",
        "avg_ts_percent",
        "avg_mvp_score",
        "avg_plus_minus",
        "games_played",
        "ppg_rank",
        "scoring_category",
        "games_missed",
        "penalized_games_missed",
        "is_mvp_candidate",
        "mvp_rank",
    ]


def test_team_player_stats(client_fixture):
    team = "DEN"

    response = client_fixture.get(f"/teams/{team}/players/stats")
    data = response.json()

    assert response.status_code == 200
    assert isinstance(data, list)
    assert len(data) > 0  # Ensure at least one player stat returned

    player_data = data[0]
    assert player_data["team"] == team
    assert set(player_data.keys()) == {
        "player",
        "season_type",
        "team",
        "full_team",
        "avg_ppg",
        "avg_ts_percent",
        "avg_mvp_score",
        "avg_plus_minus",
        "games_played",
        "ppg_rank",
        "scoring_category",
        "games_missed",
        "penalized_games_missed",
        "is_mvp_candidate",
        "mvp_rank",
    }
