from sqlalchemy.exc import IntegrityError
import pytest


def test_feature_flags_get_no_auth(client_fixture):
    response = client_fixture.get("/admin/feature_flags")

    assert response.status_code == 401
    assert response.json()["detail"] == "Not authenticated"


def test_feature_flags_get_wrong_auth(client_fixture):
    username = "test1"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    response = client_fixture.get("/admin/feature_flags")

    assert response.status_code == 401
    assert response.json()["detail"] == "You do not have the powa"


def test_feature_flags_get_success(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    response = client_fixture.get("/admin/feature_flags")

    assert response.status_code == 200
    assert "Feature Flags Page" in response.text


def test_feature_flags_create_wrong_auth(client_fixture):
    username = "test1"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )
    response = client_fixture.post(
        "/admin/feature_flags/create",
        data={
            "username": username,
            "feature_flag_name_form": ["season", "playoffs",],
            "feature_flag_is_enabled_form": [0, 0],
        },
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 401
    assert response.json()["detail"] == "You do not have the powa"


def test_feature_flags_create_success(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )
    response = client_fixture.post(
        "/admin/feature_flags/create",
        data={
            "username": username,
            "feature_flag_name_form": ["my_second_new_feature_flag",],
            "feature_flag_is_enabled_form": [1],
        },
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 200
    assert "my_second_new_feature_flag" in response.text


def test_feature_flags_create_failure_unique_contraint(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )

    # cant make a duplicate feature flag w/ the same name
    with pytest.raises(IntegrityError):
        response = client_fixture.post(
            "/admin/feature_flags/create",
            data={
                "username": username,
                "feature_flag_name_form": ["season",],
                "feature_flag_is_enabled_form": [0],
            },
            headers={"content-type": "application/x-www-form-urlencoded"},
        )


def test_feature_flags_update_success(client_fixture):
    username = "jyablonski"

    login_response = client_fixture.post(
        "/login", data={"username": username, "password": "password",},
    )
    response = client_fixture.post(
        "/admin/feature_flags",
        data={"username": username, "feature_flag_list": [0, 0, 0,],},
        headers={"content-type": "application/x-www-form-urlencoded"},
    )

    assert response.status_code == 200
