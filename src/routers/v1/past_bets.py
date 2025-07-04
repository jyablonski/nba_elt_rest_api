from datetime import datetime, timezone

from fastapi import APIRouter, Depends, Request
from fastapi.responses import StreamingResponse, Response
from sqlalchemy.orm import Session

from src.dependencies import get_db
from src.models.predictions import UserPastPredictions
from src.security import get_current_creds_from_token
from src.utils import generate_csv

router = APIRouter()


@router.post("/past_bets", response_class=StreamingResponse)
def post_user_past_bets_page(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    username = creds["username"]

    user_past_predictions = (
        (db.query(UserPastPredictions))
        .filter(UserPastPredictions.username == username)
        .order_by(UserPastPredictions.game_date.desc())
        .all()
    )
    date = datetime.now(timezone.utc).date()

    past_bet_cols = UserPastPredictions.__table__.c.keys()
    past_bet_cols.remove("id")

    csv_output = generate_csv(
        user_past_predictions, headers=past_bet_cols, report_date=date
    )

    return Response(
        content=csv_output,
        headers={
            "Content-Disposition": f"attachment; filename=bets-{username}-{date}.csv"
        },
        media_type="text/csv",
    )
