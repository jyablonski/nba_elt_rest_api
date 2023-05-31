import os


def test_create_user(client_fixture):
    username = "my_fake_user"
    response = client_fixture.post(
        "/users",
        json={
            "username": username,
            "password": "bababooiee",
            "email": "fake@user.net",
        },
    )

    assert response.status_code == 201
    assert response.json()["username"] == username


def test_create_user_from_form(client_fixture):
    response = client_fixture.post(
        "/users/create",
        data={
            "username": "test_form_user",
            "password": "bababooiee",
            "email": "fake@user.net",
        },
    )

    assert response.status_code == 200


def test_create_user_bad_request(client_fixture):
    response = client_fixture.post(
        "/users", json={"username_fake": "jyablonski", "email": "jacob@yablonski.net"}
    )

    assert response.status_code == 422
    assert (
        '[{"loc":["body","username"],"msg":"field required","type":"value_error.missing"},{"loc":["body","password"],"msg":"field required","type":"value_error.missing"}]'
        in response.text
    )


def test_update_user(client_fixture):
    new_username = "jacobs_fake_user"
    response = client_fixture.put(
        f"/users/my_fake_user",
        json={
            "username": new_username,
            "password": "bby123",
            "email": "yooo@gmail.com",
        },
    )

    assert response.json()["username"] == new_username
    assert response.status_code == 200


def test_delete_user_bad_request(client_fixture):
    response = client_fixture.delete(f"/users/jacobs_fake_user")

    assert response.json()["detail"] == "Not authenticated"
    assert response.status_code == 401


def test_delete_user_bad_key(client_fixture):
    username = "fake_user"
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer fake-token",
    }

    response = client_fixture.delete(f"/users/{username}", headers=headers,)

    assert response.json()["detail"] == "Forbidden"
    assert response.status_code == 401


def test_delete_user(client_fixture_no_auth):
    username = "jacobs_fake_user"
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {os.environ.get('API_KEY')}",
    }

    response = client_fixture_no_auth.delete(f"/users/{username}", headers=headers,)

    assert response.json() == f"Username {username} Successfully deleted!"
    assert response.status_code == 200


def test_delete_user_no_username(client_fixture):
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {os.environ.get('API_KEY')}",
    }

    response = client_fixture.delete(f"/users/jacobs_fake_user", headers=headers,)

    assert (
        response.json()["detail"]
        == "Username doesn't exist!  Please select another username."
    )
    assert response.status_code == 400


def test_delete_user_from_form(client_fixture_no_auth):
    username = "test_form_user"
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {os.environ.get('API_KEY')}",
    }

    response = client_fixture_no_auth.delete(f"/users/{username}", headers=headers,)

    assert response.json() == f"Username {username} Successfully deleted!"
    assert response.status_code == 200


def test_login_user(client_fixture):
    response = client_fixture.post(
        "/users/login", data={"username": "jyablonski", "password": "password",},
    )

    assert response.status_code == 200
