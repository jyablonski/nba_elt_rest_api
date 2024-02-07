def test_health(client_fixture):
    response = client_fixture.get("/health")
    data = response.json()

    assert response.status_code == 200
    assert data == {"status": "OK"}
