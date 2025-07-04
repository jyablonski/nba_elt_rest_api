# if the request comes from an entity that isnt logged in then redirect them
# to the login page
def test_admin_task_post_no_auth(client_fixture):
    response = client_fixture.post("/v1/invoke_dashboard_restart")

    # if response.status_code == 302:
    #     assert response.headers["Location"] == "/login"
    # else:
    assert response.status_code == 200
    assert "User Login" in response.text


def test_admin_tasks_post_wrong_auth(client_fixture, consumer_user):
    response = client_fixture.post("/v1/invoke_dashboard_restart")

    assert response.status_code == 403
    assert response.json()["detail"] == "You do not have the powa"


def test_admin_tasks_post(client_fixture, admin_user):
    response = client_fixture.post("/v1/invoke_dashboard_restart")

    assert response.status_code == 200
    assert "200 - Restarted Dashboard Successfully" in response.text
