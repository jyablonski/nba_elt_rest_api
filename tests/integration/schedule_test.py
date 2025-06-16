from datetime import datetime, timezone


def test_league_schedule(client_fixture):
    response = client_fixture.get("/league/schedule")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 2
    assert data[0]["home_team"] == "Indiana Pacers"
    assert list(data[0].keys()) == [
        "game_date",
        "day_name",
        "start_time",
        "avg_team_rank",
        "home_team",
        "home_moneyline_raw",
        "away_team",
        "away_moneyline_raw",
    ]
    assert data[0]["game_date"] == str(datetime.now(timezone.utc).date())


def test_league_schedule_date_param(client_fixture):
    date = "2023-01-01"
    response = client_fixture.get(f"/league/schedule?date={date}")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 1
    assert data[0]["home_team"] == "Atlanta Hawks"
    assert list(data[0].keys()) == [
        "game_date",
        "day_name",
        "start_time",
        "avg_team_rank",
        "home_team",
        "home_moneyline_raw",
        "away_team",
        "away_moneyline_raw",
    ]
    assert data[0]["game_date"] == date


def test_league_schedule_date_no_data(client_fixture):
    date = "2024-01-01"
    response = client_fixture.get(f"/league/schedule?date={date}")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 0
    assert response.text == "[]"


def test_league_schedule_date_fail(client_fixture):
    bad_date = "2023-01-01x"
    response = client_fixture.get(f"/league/schedule?date={bad_date}")

    assert response.status_code == 422
    assert response.json()["detail"][0] == {
        "ctx": {"error": "invalid datetime separator, expected `T`, `t`, `_` or space"},
        "input": bad_date,
        "loc": ["query", "date"],
        "msg": "Input should be a valid date or datetime, invalid datetime "
        "separator, expected `T`, `t`, `_` or space",
        "type": "date_from_datetime_parsing",
        "url": "https://errors.pydantic.dev/2.9/v/date_from_datetime_parsing",
    }
