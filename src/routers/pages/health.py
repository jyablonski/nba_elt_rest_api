from fastapi import APIRouter

from src.schemas import HealthCheck

router = APIRouter()


@router.get("/health", response_model=HealthCheck)
async def get_health():
    return HealthCheck(status="OK")
