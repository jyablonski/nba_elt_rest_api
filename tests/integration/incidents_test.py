def test_incidents_get_no_auth(client_fixture):
    response = client_fixture.get("/admin/incidents")

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


def test_incidents_get_wrong_auth(client_fixture):
    username = "test1"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    response = client_fixture.get("/admin/incidents")

    assert response.status_code == 401
    assert response.json()["detail"] == "You do not have the powa"


def test_incidents_get_success(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    response = client_fixture.get("/admin/incidents")

    assert response.status_code == 200
    assert "Incidents Page" in response.text


def test_incidents_create_wrong_auth(client_fixture):
    username = "test1"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )
    response = client_fixture.post(
        "/admin/incidents/create",
        data={
            "username": username,
            "incident_name_form": ["test1",],
            "incident_description_form": ["description1",],
            "incident_is_active_form": [0, 1],
        },
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 401
    assert response.json()["detail"] == "You do not have the powa"


def test_incidents_create_success(client_fixture):
    username = "jyablonski"
    incident_name = "jacobs_fake_test"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    response = client_fixture.post(
        "/admin/incidents/create",
        data={
            "username": username,
            "incident_name_form": [incident_name],
            "incident_description_form": [f"{incident_name} description1"],
            "incident_is_active_form": [0],
        },
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 200
    assert incident_name in response.text


def test_incidents_update_success(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    response = client_fixture.post(
        "/admin/incidents",
        data={"username": username, "incident_list": [1, 1, 1],},
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 200
