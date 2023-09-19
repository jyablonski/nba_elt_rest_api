def test_help_page(client_fixture):
    response = client_fixture.get("/help")

    assert response.status_code == 200
    assert "REST API Help Page" in response.text
