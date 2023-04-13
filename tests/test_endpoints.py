from tests.conftest import client


def test_standings():
    response = client.get("/standings")
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


def test_scorers():
    response = client.get("/scorers")
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


def test_team_ratings():
    response = client.get("/team_ratings")
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


# def test_team_ratings_individual():
#     team = "BOS"

#     response = client.get(f"/team_ratings/{team}")
#     data = response.json()

#     assert response.status_code == 200
#     assert data["team"] == "Boston Celtics"
#     assert list(data.keys()) == [
#         "team",
#         "team_acronym",
#         "w",
#         "l",
#         "ortg",
#         "drtg",
#         "nrtg",
#         "team_logo",
#         "nrtg_rank",
#         "drtg_rank",
#         "ortg_rank",
#     ]


# def test_team_ratings_individual_fail():
#     team = "JACOBS_FAKE_TEAM"

#     response = client.get(f"/team_ratings/{team}")
#     data = response.json()

#     assert response.status_code == 404
#     assert response.reason == "Not Found"
#     assert "Team not found; please use a Team Acronym:" in data["detail"]

    #
    # assert (
    #     data["detail"]
    #     == "Team not found; please use a Team Acronym: ['ATL', 'BKN', 'BOS', 'CHA', 'CHI', 'CLE', 'DAL', 'DEN',
    #        'DET', 'GSW', 'HOU', 'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIN', 'MIL', 'NOP', 'NYK', 'OKC', 'ORL',
    #        'PHI', 'PHX', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS']"
    # )


def test_twitter_comments():
    response = client.get("/twitter_comments")
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


def test_reddit_comments():
    response = client.get("/reddit_comments")
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


def test_injuries():
    response = client.get("/injuries")
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


# def test_injuries_team():
#     team = "IND"

#     response = client.get(f"/injuries/{team}")
#     data = response.json()

#     assert response.status_code == 200
#     assert data["player"] == "Myles Turner"
#     assert list(data.keys()) == [
#         "player",
#         "team_acronym",
#         "team",
#         "date",
#         "status",
#         "injury",
#         "description",
#         "total_injuries",
#         "team_active_injuries",
#         "team_active_protocols",
#     ]

# def test_injuries_team_fail():
#     team = "JACOBS_FAKE_TEAM"

#     response = client.get(f"/injuries/{team}")
#     data = response.json()

#     assert response.status_code == 404
#     assert response.reason == "Not Found"
#     assert "Team not found; please use a Team Acronym:" in data["detail"]

    #
    # assert (
    #     data["detail"]
    #     == "Team not found; please use a Team Acronym: ['ATL', 'BKN', 'BOS', 'CHA', 'CHI', 'CLE', 'DAL', 'DEN',
    #        'DET', 'GSW', 'HOU', 'IND', 'LAC', 'LAL', 'MEM', 'MIA', 'MIN', 'MIL', 'NOP', 'NYK', 'OKC', 'ORL',
    #        'PHI', 'PHX', 'POR', 'SAC', 'SAS', 'TOR', 'UTA', 'WAS']"
    # )

def test_game_types():
    response = client.get("/game_types")
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


def test_schedule():
    response = client.get("/schedule")
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


def test_predictions():
    response = client.get("/predictions")
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
def test_feedback():
    response = client.post("/feedback", data='{"user_feedback": "hello world"}')
    data = response.json()

    assert response.status_code == 422
    