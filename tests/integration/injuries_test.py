def test_league_injuries(client_fixture):
    response = client_fixture.get("/league/injuries")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 142
    assert data[0]["player"] == "A.J. Green"
    assert list(data[0].keys()) == [
        "player",
        "team_acronym",
        "injury_status",
        "injury",
        "injury_description",
        "scrape_date",
    ]


def test_team_injuries(client_fixture):
    team = "IND"

    response = client_fixture.get(f"/teams/{team}/injuries")
    data = response.json()

    assert response.status_code == 200
    assert isinstance(data, list) and len(data) > 0  # ensure it’s a non-empty list

    first_injury = data[0]
    assert first_injury["player"] == "Bennedict Mathurin"
    assert list(first_injury.keys()) == [
        "player",
        "team_acronym",
        "injury_status",
        "injury",
        "injury_description",
        "scrape_date",
    ]


def test_injuries_team_fail(client_fixture):
    team = "JACOBS_FAKE_TEAM"

    response = client_fixture.get(f"/teams/{team}/injuries")

    assert response.status_code == 404

    # assert (
    #     data["detail"]
    #     == "Team not found; please use a Team Acronym: ['ATL', 'BKN', 'BOS', 'CHA', 'CHI', 'CLE', 'DAL', 'DEN',
    #        'DET', 'GSW', 'HOU', 'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIN', 'MIL', 'NOP', 'NYK', 'OKC', 'ORL',
    #        'PHI', 'PHX', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS']"
    # )
