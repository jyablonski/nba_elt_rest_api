from fastapi import APIRouter, Request
from src.schemas import HousingPredictionBase

router = APIRouter()


# EXAMPLE endpoint to serve an ML Model over a POST endpoint
# users can send post requests w/ their parameters and the API
# can use those to return a response
@router.post("/ml/predict")
def return_ml_prediction(
    request: Request,
    housing_prediction_request: HousingPredictionBase,
):
    if housing_prediction_request.state in ("CA", "FL", "HI", "NY"):
        state_coefficient = 1.25
    else:
        state_coefficient = 0.75

    predicted_price = (
        (housing_prediction_request.square_ft * 100)
        + (housing_prediction_request.num_stories * 75000)
        + (housing_prediction_request.qol_index * 5000)
    ) * state_coefficient

    predicted_price = int("{:.0f}".format(predicted_price))

    return {"predicted_price": predicted_price}
