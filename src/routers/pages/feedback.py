from fastapi import APIRouter, Request
from fastapi.responses import HTMLResponse

from src.utils import templates

router = APIRouter()


@router.get("/internal/feedback", response_class=HTMLResponse)
def form_get(request: Request):
    return templates.TemplateResponse("feedback.html", {"request": request})
