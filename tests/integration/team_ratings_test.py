def test_league_ratings(client_fixture):
    response = client_fixture.get("/v1/league/ratings")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["team"] == "Boston Celtics"
    assert list(data[0].keys()) == [
        "team",
        "team_acronym",
        "wins",
        "losses",
        "ortg",
        "drtg",
        "nrtg",
        "team_logo",
        "nrtg_rank",
        "drtg_rank",
        "ortg_rank",
    ]


def test_team_ratings(client_fixture):
    team = "BOS"

    response = client_fixture.get(f"/v1/teams/{team}/ratings")
    data = response.json()

    assert response.status_code == 200
    assert data[0]["team"] == "Boston Celtics"
    assert list(data[0].keys()) == [
        "team",
        "team_acronym",
        "wins",
        "losses",
        "ortg",
        "drtg",
        "nrtg",
        "team_logo",
        "nrtg_rank",
        "drtg_rank",
        "ortg_rank",
    ]


def test_team_ratings_fail(client_fixture):
    team = "JACOBS_FAKE_TEAM"

    response = client_fixture.get(f"/v1/teams/{team}/ratings")

    assert response.status_code == 404

    #
    # assert (
    #     data["detail"]
    #     == "Team not found; please use a Team Acronym: ['ATL', 'BKN', 'BOS', 'CHA', 'CHI', 'CLE', 'DAL', 'DEN',
    #        'DET', 'GSW', 'HOU', 'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIN', 'MIL', 'NOP', 'NYK', 'OKC', 'ORL',
    #        'PHI', 'PHX', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS']"
    # )
