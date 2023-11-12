import pytest


@pytest.mark.parametrize(
    "test_input,expected_output",
    [
        (
            {"state": "NY", "square_ft": 2150, "num_stories": 3, "qol_index": 13.5},
            634375,
        ),
        (
            {"state": "CA", "square_ft": 3000, "num_stories": 2, "qol_index": 10.2},
            626250,
        ),
        (
            {"state": "MD", "square_ft": 3000, "num_stories": 2, "qol_index": 10.2},
            375750,
        ),
        (
            {"state": "IL", "square_ft": 1750, "num_stories": 1, "qol_index": 2.5},
            196875,
        ),
    ],
)
def test_ml_housing_prediction(client_fixture, test_input, expected_output):
    df = client_fixture.post(
        "/ml/predict",
        json=test_input,
    )
    assert df.status_code == 200
    assert df.json()["predicted_price"] == expected_output


def test_ml_housing_prediction_bad_request(client_fixture):
    bad_parameter = "num_stories"

    df = client_fixture.post(
        "/ml/predict",
        json={"state": "IL", "square_ft": 1750, bad_parameter: 1.2, "qol_index": 2.5},
    )

    assert df.status_code == 422
    assert df.json()["detail"][0]["loc"][1] == bad_parameter
    assert (
        df.json()["detail"][0]["msg"]
        == "Input should be a valid integer, got a number with a fractional part"
    )
