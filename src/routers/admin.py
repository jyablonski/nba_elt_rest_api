from fastapi import APIRouter, Depends, HTTPException, Request, status
from fastapi.responses import HTMLResponse

from src.security import get_current_user_from_token
from src.utils import templates

router = APIRouter()


@router.get("/admin", response_class=HTMLResponse)
def get_admin(
    request: Request,
    username: str = Depends(get_current_user_from_token),
):
    if username != "jyablonski":
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You do not have the powa",
        )

    return templates.TemplateResponse("admin.html", {"request": request})
