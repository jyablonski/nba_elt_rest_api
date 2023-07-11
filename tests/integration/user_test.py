import json
import os
import random

import pytest

from src.security import get_current_user_from_api_token


def test_create_user(client_fixture):
    number = random.randint(0, 1000)
    username = f"my_fake_user_{number}"

    response = client_fixture.post(
        "/users",
        json={"username": username, "password": "password", "email": "fake@user.net",},
    )

    assert response.status_code == 201
    assert response.json()["username"] == username


def test_create_user_from_api(client_fixture):
    username = "test_api_user"

    response = client_fixture.post(
        "/users",
        json={
            "username": username,
            "password": "bababooiee",
            "email": "fake@user.net",
        },
    )

    assert response.status_code == 201


def test_create_user_from_form(client_fixture):
    username = "test_form_user"

    response = client_fixture.post(
        "/login/create_user",
        data={
            "username": username,
            "password": "password",
            "email": "fake@formuser.net",
        },
    )

    assert response.status_code == 200
    assert username in response.text


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
    new_username = "test_form_user_v2"

    response = client_fixture.put(
        f"/users/test_form_user",
        json={
            "username": new_username,
            "password": "bababooiee",
            "email": "yooo@gmail.com",
        },
    )

    assert response.json()["username"] == new_username
    assert response.status_code == 200


def test_update_user_doesnt_exist(client_fixture):
    new_username = "bigfakeuser"
    existing_username = "test55"

    response = client_fixture.put(
        f"/users/{existing_username}",
        json={
            "username": new_username,
            "password": "bababooiee",
            "email": "yooo@gmail.com",
        },
    )

    assert response.status_code == 404
    assert "this doesn't exist hoe" in response.text


def test_update_user_username_taken(client_fixture):
    new_username = "jyablonski"
    existing_username = "test1"

    response = client_fixture.put(
        f"/users/{existing_username}",
        json={
            "username": new_username,
            "password": "bababooiee",
            "email": "yooo@gmail.com",
        },
    )

    assert (
        response.json()["detail"]
        == "The new requested Username already exists!  Please select another username."
    )
    assert response.status_code == 409


def test_delete_user_no_token(client_fixture):
    response = client_fixture.delete(f"/users/jacobs_fake_user")

    assert response.json()["detail"] == "Not authenticated"
    assert response.status_code == 401


def test_delete_user_bad_token(client_fixture):
    username = "fake_user"
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer fake-token",
    }

    response = client_fixture.delete(f"/users/{username}", headers=headers,)

    assert response.json()["detail"] == "Could not validate credentials"
    assert response.status_code == 401


def test_delete_user_no_username(client_fixture):
    username = "jacobs_fake_user"
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {os.environ.get('API_KEY')}",
    }

    response = client_fixture.delete(f"/users/{username}", headers=headers,)

    assert response.json()["detail"] == "Could not validate credentials"
    assert response.status_code == 401


def test_delete_user(client_fixture):
    username = "jacob123"
    password = "password"

    response = client_fixture.post(
        "/users",
        json={"username": username, "password": password, "email": "fake@user.net",},
    )

    df = client_fixture.post(
        f"/token", data={"username": username, "password": password}
    )

    token = df.json()["access_token"]

    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}",
    }
    response = client_fixture.delete(f"/users/{username}", headers=headers)
    assert response.json() == f"Username {username} Successfully deleted!"
    assert response.status_code == 200


def test_delete_user_no_permissions(client_fixture):
    username = "jacob456"
    real_username = "jyablonski"
    password = "password"

    response = client_fixture.post(
        "/users",
        json={"username": username, "password": password, "email": "fake@user.net",},
    )

    df = client_fixture.post(
        f"/token", data={"username": username, "password": password}
    )
    token = df.json()["access_token"]

    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {token}",
    }
    response = client_fixture.delete(f"/users/{real_username}", headers=headers)

    assert response.status_code == 401
    assert (
        response.json()["detail"]
        == f"{username} is not authenticated to perform this action on {real_username}"
    )
