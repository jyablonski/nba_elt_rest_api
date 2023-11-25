from starlette.testclient import TestClient

from src.server import app


def test_cache_functionality():
    with TestClient(app) as client:
        response = client.get("/game_types")
        assert response.headers.get("cache-control") == "max-age=900"
        assert response.status_code == 200
