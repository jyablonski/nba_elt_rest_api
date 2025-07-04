from typing import Annotated

from fastapi import APIRouter, Depends, Form, Request
from fastapi.responses import HTMLResponse, RedirectResponse
from sqlalchemy.orm import Session

from src.crud.predictions import (
    get_user_bets_context,
    process_user_bet_submission,
)
from src.dependencies import get_db
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.get("/bets", response_class=HTMLResponse)
async def get_user_bets_page(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    db: Session = Depends(get_db),
):
    username = creds.get("username")
    if not username:
        return RedirectResponse("/login")

    context = get_user_bets_context(db, username=username, request=request)
    return templates.TemplateResponse("bets.html", context)


@router.post("/bets")
def store_user_bets_predictions_from_ui(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
    bet_predictions: Annotated[list[str], Form(...)] = None,
    bet_amounts: Annotated[list[int], Form(...)] = None,
    db: Session = Depends(get_db),
) -> HTMLResponse:
    username = creds["username"]

    process_user_bet_submission(db, username, bet_predictions, bet_amounts)

    return templates.TemplateResponse(
        "bets.html",
        {
            "request": request,
            "username": username,
        },
    )
