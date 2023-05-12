def test_standings(client_fixture):
    response = client_fixture.get("/standings")
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


def test_scorers(client_fixture):
    response = client_fixture.get("/scorers")
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


def test_team_ratings(client_fixture):
    response = client_fixture.get("/team_ratings")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["team"] == "Boston Celtics"
    assert list(data[0].keys()) == [
        "team",
        "team_acronym",
        "w",
        "l",
        "ortg",
        "drtg",
        "nrtg",
        "team_logo",
        "nrtg_rank",
        "drtg_rank",
        "ortg_rank",
    ]


def test_team_ratings_individual(client_fixture):
    team = "BOS"

    response = client_fixture.get(f"/team_ratings/{team}")
    data = response.json()

    assert response.status_code == 200
    assert data["team"] == "Boston Celtics"
    assert list(data.keys()) == [
        "team",
        "team_acronym",
        "w",
        "l",
        "ortg",
        "drtg",
        "nrtg",
        "team_logo",
        "nrtg_rank",
        "drtg_rank",
        "ortg_rank",
    ]


def test_team_ratings_individual_fail(client_fixture):
    team = "JACOBS_FAKE_TEAM"

    response = client_fixture.get(f"/team_ratings/{team}")
    data = response.json()

    assert response.status_code == 404
    assert response.reason == "Not Found"
    assert "Team not found; please use a Team Acronym:" in data["detail"]

    #
    # assert (
    #     data["detail"]
    #     == "Team not found; please use a Team Acronym: ['ATL', 'BKN', 'BOS', 'CHA', 'CHI', 'CLE', 'DAL', 'DEN',
    #        'DET', 'GSW', 'HOU', 'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIN', 'MIL', 'NOP', 'NYK', 'OKC', 'ORL',
    #        'PHI', 'PHX', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS']"
    # )


def test_twitter_comments(client_fixture):
    response = client_fixture.get("/twitter_comments")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["username"] == "KingJames"
    assert list(data[0].keys()) == [
        "scrape_ts",
        "username",
        "tweet",
        "url",
        "likes",
        "retweets",
        "compound",
        "neg",
        "neu",
        "pos",
    ]


def test_reddit_comments(client_fixture):
    response = client_fixture.get("/reddit_comments")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["author"] == "rattatatouille"
    assert list(data[0].keys()) == [
        "scrape_date",
        "author",
        "comment",
        "flair",
        "score",
        "url",
        "compound",
        "neg",
        "neu",
        "pos",
    ]


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
    data = response.json()

    assert response.status_code == 404
    assert response.reason == "Not Found"
    assert "Team not found; please use a Team Acronym:" in data["detail"]

    # assert (
    #     data["detail"]
    #     == "Team not found; please use a Team Acronym: ['ATL', 'BKN', 'BOS', 'CHA', 'CHI', 'CLE', 'DAL', 'DEN',
    #        'DET', 'GSW', 'HOU', 'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIN', 'MIL', 'NOP', 'NYK', 'OKC', 'ORL',
    #        'PHI', 'PHX', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS']"
    # )


def test_game_types(client_fixture):
    response = client_fixture.get("/game_types")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 4
    assert data[0]["game_type"] == "20 pt Game"
    assert list(data[0].keys()) == [
        "game_type",
        "type",
        "n",
        "explanation",
    ]


def test_schedule(client_fixture):
    response = client_fixture.get("/schedule")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["home_team"] == "Indiana Pacers"
    assert list(data[0].keys()) == [
        "date",
        "day",
        "start_time",
        "avg_team_rank",
        "home_team",
        "home_moneyline_raw",
        "away_team",
        "away_moneyline_raw",
    ]


def test_predictions(client_fixture):
    response = client_fixture.get("/predictions")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["home_team"] == "Indiana Pacers"
    assert list(data[0].keys()) == [
        "proper_date",
        "home_team",
        "home_team_predicted_win_pct",
        "away_team",
        "away_team_predicted_win_pct",
    ]


# didnt get this workin
def test_feedback(client_fixture):
    response = client_fixture.post("/feedback", data='{"user_feedback": "hello world"}')
    data = response.json()

    assert response.status_code == 422


def test_transactions(client_fixture):
    response = client_fixture.get("/transactions")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["transaction"] == "The Portland Trail Blazers signed Skylar Mays."
    assert list(data[0].keys()) == [
        "date",
        "transaction",
    ]


def test_create_user(client_fixture):
    response = client_fixture.post(
        "/users", json={"username": "my_fake_user", "email": "fake@user.net"}
    )

    assert response.status_code == 201


def test_update_user(client_fixture):
    response = client_fixture.put(
        f"/users/my_fake_user",
        json={"username": "jacobs_fake_user", "email": "yooo@gmail.com"},
    )

    assert response.status_code == 200


def test_delete_user(client_fixture):
    response = client_fixture.delete(
        f"/users/jacobs_fake_user", json={"api_key": "aaaa"}
    )

    assert response.status_code == 200


def test_delete_user_bad_request(client_fixture):
    response = client_fixture.delete(f"/users/jacobs_fake_user")

    assert response.status_code == 422


def test_delete_user_bad_api_key(client_fixture):
    response = client_fixture.delete(
        f"/users/jacobs_fake_user", json={"api_key": "bbbb"}
    )

    assert response.status_code == 403


def test_create_user_bad_request(client_fixture):
    response = client_fixture.post(
        "/users", json={"username_fake": "jyablonski", "email": "jacob@yablonski.net"}
    )

    assert response.status_code == 422
