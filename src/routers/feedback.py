from fastapi import APIRouter, Depends, Form, Request
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.dao.feedback import send_feedback
from src.dependencies import get_db
from src.schemas import FeedbackBase
from src.utils import templates

router = APIRouter()


@router.get("/internal/feedback", response_class=HTMLResponse)
def form_get(request: Request):
    return templates.TemplateResponse("feedback.html", {"request": request})


@router.post("/internal/feedback", response_model=FeedbackBase)
def post_feedback(
    request: Request, user_feedback: str = Form(...), db: Session = Depends(get_db)
):
    send_feedback(db, user_feedback)
    return templates.TemplateResponse(
        "feedback.html",
        {"request": request, "feedback_response": "Your feedback has been stored!"},
    )
