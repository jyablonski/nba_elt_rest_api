def test_injuries(client_fixture):
    response = client_fixture.get("/injuries")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["player"] == "Myles Turner"
    assert list(data[0].keys()) == [
        "player",
        "team_acronym",
        "team",
        "date",
        "status",
        "injury",
        "description",
        "total_injuries",
        "team_active_injuries",
        "team_active_protocols",
    ]


def test_injuries_team(client_fixture):
    team = "IND"

    response = client_fixture.get(f"/injuries/{team}")
    data = response.json()

    assert response.status_code == 200
    assert data["player"] == "Myles Turner"
    assert list(data.keys()) == [
        "player",
        "team_acronym",
        "team",
        "date",
        "status",
        "injury",
        "description",
        "total_injuries",
        "team_active_injuries",
        "team_active_protocols",
    ]


def test_injuries_team_fail(client_fixture):
    team = "JACOBS_FAKE_TEAM"

    response = client_fixture.get(f"/injuries/{team}")

    assert response.status_code == 404

    # assert (
    #     data["detail"]
    #     == "Team not found; please use a Team Acronym: ['ATL', 'BKN', 'BOS', 'CHA', 'CHI', 'CLE', 'DAL', 'DEN',
    #        'DET', 'GSW', 'HOU', 'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIN', 'MIL', 'NOP', 'NYK', 'OKC', 'ORL',
    #        'PHI', 'PHX', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS']"
    # )
