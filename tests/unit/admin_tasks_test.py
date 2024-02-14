from __future__ import annotations


import os
from typing import TYPE_CHECKING

import pytest

from src.admin_tasks import invoke_restart_dashboard

if TYPE_CHECKING:
    from pytest_mock import MockerFixture


@pytest.mark.parametrize(
    "env_type, expected_response",
    [
        (
            "prod",
            {
                "response_code": 200,
                "response_message": "Restarted Dashboard Successfully",
            },
        ),
        (
            "prod",
            {
                "response_code": 402,
                "response_message": "An Error Occurred when Invoking the Restart Dashboard Lambda",
            },
        ),
        (
            "dev",
            {
                "response_code": 200,
                "response_message": "Restarted Dashboard Successfully",
            },
        ),
    ],
)
def test_invoke_restart_dashboard(
    env_type: str, expected_response: dict[str, str | int], mocker: MockerFixture
):
    os.environ["ENV_TYPE"] = env_type
    mocker.patch("src.admin_tasks.boto3.client").return_value = 1
    mocker.patch("src.admin_tasks.boto3.client").return_value.invoke.return_value = {
        "StatusCode": expected_response["response_code"]
    }

    # Call the function to be tested
    result = invoke_restart_dashboard()

    # Assertions
    assert result == expected_response
