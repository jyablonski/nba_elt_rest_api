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
        "season_avg_ppg",
        "playoffs_avg_ppg",
        "season_ts_percent",
        "playoffs_ts_percent",
        "games_played",
        "playoffs_games_played",
        "ppg_rank",
        "top20_scorers",
        "player_mvp_calc_adj",
        "games_missed",
        "penalized_games_missed",
        "top5_candidates",
        "mvp_rank",
    ]
