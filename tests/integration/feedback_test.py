import random


def test_feedback_get(client_fixture):
    response = client_fixture.get("/feedback")

    assert response.status_code == 200
    assert "Enter your feedback ..." in response.text


def test_feedback_fail(client_fixture):
    response = client_fixture.post("/feedback", data='{"user_feedback": "hello world"}')

    assert response.status_code == 422


def test_feedback_success(client_fixture):
    number = random.random()

    response = client_fixture.post(
        "/feedback",
        data={"user_feedback": f"hello world {number}"},
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 200
    assert "Your feedback has been stored!" in response.text


def test_feedback_missing_value(client_fixture):
    response = client_fixture.post(
        "/feedback",
        data={"user_feedback": ""},
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 422
    assert response.json() == {
        "detail": [
            {
                "type": "missing",
                "loc": ["body", "user_feedback"],
                "msg": "Field required",
                "input": None,
                "url": "https://errors.pydantic.dev/2.6/v/missing",
            }
        ]
    }
