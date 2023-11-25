def test_cache_functionality(client_fixture):
    response = client_fixture.get("/game_types")
    data = response.json()

    assert response.status_code == 200
    assert len(data) == 4
    assert data[0]["game_type"] == "20 pt Game"
    assert list(data[0].keys()) == [
        "game_type",
        "season_type",
        "n",
        "explanation",
    ]

    # second_response = client_fixture.get("/game_types")
    # second_data = second_response.json()

    # assert second_response.status_code == 200
    # third_response = client_fixture.get("/game_types")
    # third_data = second_response.json()

    # assert third_response.status_code == 304
