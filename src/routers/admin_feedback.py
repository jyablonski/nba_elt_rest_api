from fastapi import APIRouter, Depends, HTTPException, Request, status
from fastapi.responses import HTMLResponse
from sqlalchemy.orm import Session

from src.dao.feedback import get_feedback
from src.database import get_db
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.get("/admin/feedback", response_class=HTMLResponse)
def get_admin_feedback(
    request: Request,
    db: Session = Depends(get_db),
    creds: dict[str, str] = Depends(get_current_creds_from_token),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    feedback = get_feedback(db=db)
    return templates.TemplateResponse(
        "admin_feedback.html", {"request": request, "all_feedback": feedback}
    )
