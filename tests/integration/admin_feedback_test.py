def test_admin_feedback_get_wrong_auth(client_fixture, consumer_user):
    response = client_fixture.get("/admin/feedback")

    assert response.status_code == 403
    assert response.json()["detail"] == "You do not have the powa"


def test_admin_feedback_get(client_fixture, admin_user):
    response = client_fixture.get("/admin/feedback")

    assert response.status_code == 200
    assert "Current Feedback List" in response.text
