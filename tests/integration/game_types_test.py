def test_league_game_types(client_fixture):
    response = client_fixture.get("/v1/league/game_types")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 4
    assert data[0]["game_type"] == "20 pt Game"
    assert list(data[0].keys()) == [
        "game_type",
        "season_type",
        "n",
        "explanation",
    ]


def test_team_game_types(client_fixture):
    team = "IND"

    response = client_fixture.get(f"/v1/teams/{team}/game_types")
    data = response.json()

    assert response.status_code == 200
    assert isinstance(data, list)
    assert len(data) == 4

    expected_game_types = {"20 pt Game", "Blowout Game", "10 pt Game", "Clutch Game"}
    actual_game_types = {item["game_type"] for item in data}
    assert expected_game_types == actual_game_types

    for item in data:
        assert item["team"] == "IND"
        assert set(item.keys()) == {
            "team",
            "game_type",
            "season_type",
            "n",
            "explanation",
        }
