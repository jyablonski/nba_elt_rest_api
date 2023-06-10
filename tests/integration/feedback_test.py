import random

# didnt get this workin
def test_feedback_get(client_fixture):
    response = client_fixture.get("/feedback")

    assert response.status_code == 200
    assert "Enter your feedback ..." in response.text


# didnt get this workin
def test_feedback_fail(client_fixture):
    response = client_fixture.post("/feedback", data='{"user_feedback": "hello world"}')
    data = response.json()

    assert response.status_code == 422


# didnt get this workin
def test_feedback_success(client_fixture):
    number = random.random()

    response = client_fixture.post(
        "/feedback",
        data={"user_feedback": f"hello world {number}"},
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 200
    assert "Your feedback has been stored!" in response.text