from fastapi import APIRouter, Depends, HTTPException, Request, status
from fastapi.responses import HTMLResponse

from src.admin_tasks import invoke_restart_dashboard
from src.security import get_current_creds_from_token
from src.utils import templates

router = APIRouter()


@router.post("/invoke_dashboard_restart", response_class=HTMLResponse)
def post_dashboard_restart(
    request: Request,
    creds: dict[str, str] = Depends(get_current_creds_from_token),
):
    if creds["role"] != "Admin":
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="You do not have the powa",
        )

    lambda_operation_response = invoke_restart_dashboard()
    return templates.TemplateResponse(
        "admin.html",
        {
            "request": request,
            "admin_task_message": lambda_operation_response["response_message"],
            "admin_task_response_code": lambda_operation_response["response_code"],
        },
    )
