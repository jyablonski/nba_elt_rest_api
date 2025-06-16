def test_league_standings(client_fixture):
    response = client_fixture.get("/league/standings")
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


def test_team_standings(client_fixture):
    team = "MIL"

    response = client_fixture.get(f"/teams/{team}/standings")
    data = response.json()

    assert response.status_code == 200
    assert isinstance(data, list)
    assert len(data) > 0

    standing = data[0]
    assert standing["team"] == team
    assert set(standing.keys()) == {
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
    }
