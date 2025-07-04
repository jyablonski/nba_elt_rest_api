from fastapi import APIRouter, Depends, Form, Request
from sqlalchemy.orm import Session

from src.crud.feedback import send_feedback
from src.dependencies import get_db
from src.schemas import FeedbackBase
from src.utils import templates

router = APIRouter()


@router.post("/internal/feedback", response_model=FeedbackBase)
def post_feedback(
    request: Request, user_feedback: str = Form(...), db: Session = Depends(get_db)
):
    send_feedback(db, user_feedback)
    return templates.TemplateResponse(
        "feedback.html",
        {"request": request, "feedback_response": "Your feedback has been stored!"},
    )
