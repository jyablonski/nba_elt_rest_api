# didnt get this workin
def test_feedback(client_fixture):
    response = client_fixture.post("/feedback", data='{"user_feedback": "hello world"}')
    data = response.json()

    assert response.status_code == 422
