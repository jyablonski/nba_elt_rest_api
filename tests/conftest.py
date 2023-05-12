import json
import os

from fastapi.testclient import TestClient
import pytest
import pytest_mock

from src.main import app

# client = TestClient(app)


@pytest.fixture()
def client_fixture():
    os.environ["API_KEY"] = "aaaa"
    client = TestClient(app)

    yield client


@pytest.fixture()
def standings_fixture():
    """Fixture that returns static Standings Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/standings.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)

    return df


@pytest.fixture()
def game_types_fixture():
    """Fixture that returns static Game Types Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/game_types.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)

    return df


@pytest.fixture()
def injuries_fixture():
    """Fixture that returns static Injuries Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/injuries.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)

    return df


@pytest.fixture()
def injuries_team_fixture():
    """Fixture that returns static Injury Team Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/injuries_team.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)

    return df


@pytest.fixture()
def reddit_comments_fixture():
    """Fixture that returns static Reddit Comments Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/reddit_comments.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)

    return df


@pytest.fixture()
def scorers_fixture():
    """Fixture that returns static Scorers Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/scorers.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)

    return df


@pytest.fixture()
def team_ratings_fixture():
    """Fixture that returns static Team Ratings Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/team_ratings.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)

    return df


@pytest.fixture()
def team_ratings_team_fixture():
    """Fixture that returns static Team Ratings Team Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/team_ratings_team.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)

    return df


@pytest.fixture()
def twitter_comments_fixture():
    """Fixture that returns static Twitter Data """

    fname = os.path.join(os.path.dirname(__file__), "fixtures/twitter_comments.json")

    with open(fname, "r") as openfile:
        df = json.load(openfile)
    return df
