from fastapi import Request, Response
import pytest

from src.cache import key_builder_no_db


# putting it into `namespace:<md5 cornbeefhash>`
# the db key gets popped so it shouldnt affect the hash
@pytest.mark.parametrize(
    "kwargs_input,expected_output",
    [
        (
            {"key1": "value1", "key2": "value2", "db": "db"},
            "namespace:70e8dc42d1b196951108ff94c103707f",
        ),
        (
            {"key1": "value1", "key2": "value2", "db": "db5"},
            "namespace:70e8dc42d1b196951108ff94c103707f",
        ),
        (
            {"key1": "value_different", "key2": "value2", "db": "db"},
            "namespace:b78096008cc403dc1905df6cb59ee145",
        ),
    ],
)
def test_key_builder_no_db(kwargs_input: dict[str, str], expected_output: str, mocker):
    func = mocker.Mock(__module__="module", __name__="function")
    namespace = "namespace"
    request = mocker.Mock(spec=Request)
    response = mocker.Mock(spec=Response)
    args = ("arg1", "arg2")
    kwargs = kwargs_input

    actual_key = key_builder_no_db(
        func, namespace, request=request, response=response, args=args, kwargs=kwargs
    )
    assert actual_key == expected_output
