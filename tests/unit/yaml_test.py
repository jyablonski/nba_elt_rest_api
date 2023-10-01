import os


def test_yaml_load_with_env_vars(config_fixture):
    env_type = "dev"
    config = config_fixture[env_type]

    assert config_fixture["project"]["name"] == "REST_API_TEST"
    assert len(config_fixture) == 2
    assert config["database"] == "postgres"
    assert config["host"] == "PYTEST"
    assert config["user"] == "jacob"
    assert config["pass"] == "password"
