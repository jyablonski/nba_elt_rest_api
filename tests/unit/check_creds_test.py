from fastapi import HTTPException, status
import pytest

from src.security import check_creds


@pytest.mark.parametrize(
    "kwargs_input, check_type, expected_output",
    [
        (
            {"username": "value1", "role": "Consumer", "expires_at": "test"},
            "Username",
            None,
        ),
        ({"username": "value1", "role": "Admin", "expires_at": "test"}, "Admin", None),
        (
            {"username": "value1", "role": "Consumer", "expires_at": "test"},
            "Admin",
            HTTPException(status_code=status.HTTP_403_FORBIDDEN),
        ),
        (
            {"username": "", "role": "Consumer", "expires_at": "test"},
            "Username",
            HTTPException(status_code=status.HTTP_401_UNAUTHORIZED),
        ),
    ],
)
def test_check_creds_valid(
    kwargs_input: dict[str, str], check_type: str, expected_output
):
    if isinstance(expected_output, Exception):
        with pytest.raises(type(expected_output)) as exc_info:
            result = check_creds(creds=kwargs_input, check_type=check_type)

        assert exc_info.value.status_code == expected_output.status_code

    else:
        result = check_creds(creds=kwargs_input, check_type=check_type)
        assert result is expected_output


# def test_check_creds(
#     kwargs_input: dict[str, str], check_type: str, expected_exception: Exception
# ):
#     if expected_exception:
#         with pytest.raises(type(expected_exception)) as exc_info:
#             check_creds(creds=kwargs_input, check_type=check_type)
#         assert exc_info.value.status_code == expected_exception.status_code
#     else:
#         result = check_creds(creds=kwargs_input, check_type=check_type)
#         assert result is None
