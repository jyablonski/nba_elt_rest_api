def test_home(client_fixture):
    response = client_fixture.get("/")

    assert response.status_code == 200
    assert "REST API Serving Data for NBA ELT Pipeline Project" in response.text
