from fastapi import APIRouter

from .admin import router as admin_router
from .bets import router as bets_router
from .feedback import router as feedback_router
from .health import router as health_router
from .help_page import router as help_page_router
from .login import router as login_router
from .settings import router as settings_router
from .team_events import router as team_events_router

pages_router = APIRouter()

pages_router.include_router(admin_router, tags=["admin"])
pages_router.include_router(bets_router, tags=["bets"])
pages_router.include_router(feedback_router, tags=["feedback"])
pages_router.include_router(health_router, tags=["health"])
pages_router.include_router(help_page_router, tags=["help-page"])
pages_router.include_router(login_router, tags=["login"])
pages_router.include_router(settings_router, tags=["settings"])
pages_router.include_router(team_events_router, tags=["team-events"])
