from starlette.testclient import TestClient

from src.server import app


def test_cache_functionality(client_fixture):
    response = client_fixture.get("/game_types")
    assert response.headers.get("cache-control") == "max-age=900"
    assert response.status_code == 200
