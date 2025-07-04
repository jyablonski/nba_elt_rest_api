from typing import Any

from fastapi import APIRouter, Request
from fastapi.responses import HTMLResponse
from src.utils import templates

router = APIRouter()


@router.get("/help", response_class=HTMLResponse)
async def form_get(request: Request) -> Any:
    return templates.TemplateResponse("help_page.html", {"request": request})
