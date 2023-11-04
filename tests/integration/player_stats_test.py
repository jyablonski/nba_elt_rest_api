def test_player_stats(client_fixture):
    response = client_fixture.get("/player_stats")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["player"] == "Nikola Jokic"
    assert list(data[0].keys()) == [
        "player",
        "team",
        "full_team",
        "avg_ppg",
        "avg_ts_percent",
        "avg_mvp_score",
        "games_played",
        "ppg_rank",
        "is_top_scorer",
        "games_missed",
        "penalized_games_missed",
        "is_top_candidate",
        "mvp_rank",
    ]
