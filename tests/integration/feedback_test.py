import random


def test_internal_feedback_get(client_fixture):
    response = client_fixture.get("/internal/feedback")

    assert response.status_code == 200
    assert "Enter your feedback ..." in response.text


def test_internal_feedback_fail(client_fixture):
    response = client_fixture.post(
        "/v1/internal/feedback", data='{"user_feedback": "hello world"}'
    )

    assert response.status_code == 422


def test_internal_feedback_success(client_fixture):
    number = random.random()

    response = client_fixture.post(
        "/v1/internal/feedback",
        data={"user_feedback": f"hello world {number}"},
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 200
    assert "Your feedback has been stored!" in response.text


def test_internal_feedback_missing_value(client_fixture):
    response = client_fixture.post(
        "/v1/internal/feedback",
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
                "url": "https://errors.pydantic.dev/2.9/v/missing",
            }
        ]
    }
