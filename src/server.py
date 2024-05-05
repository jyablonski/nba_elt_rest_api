import os

from fastapi import FastAPI, Request
from fastapi_cache import FastAPICache
from fastapi_cache.backends.inmemory import InMemoryBackend
from fastapi_cache.backends.redis import RedisBackend
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from mangum import Mangum
from opentelemetry import trace
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from redis import asyncio as aioredis
from starlette.middleware.sessions import SessionMiddleware

from starlette.middleware.base import BaseHTTPMiddleware

# from prometheus_fastapi_instrumentator import Instrumentator
# if i ever swap to ecs ;-)

from src.models import Base
from src.database import engine

from src.middleware import log_middleware
from src.routers.admin import router as admin_router
from src.routers.admin_feedback import router as admin_feedback_router
from src.routers.auth import router as auth_router
from src.routers.bets import router as bets_router
from src.routers.feature_flags import router as feature_flags_router
from src.routers.feedback import router as feedback_router
from src.routers.game_types import router as game_types_router
from src.routers.gmail_auth import router as gmail_auth_router
from src.routers.help_page import router as help_page_router
from src.routers.incidents import router as incidents_router
from src.routers.injuries import router as injuries_router
from src.routers.login import router as login_router
from src.routers.health import router as health_router
from src.routers.past_bets import router as past_bets_router
from src.routers.player_stats import router as player_stats_router
from src.routers.predictions import router as predictions_router
from src.routers.reddit_comments import router as reddit_comments_router
from src.routers.reporting import router as reporting_router
from src.routers.settings import router as settings_router
from src.routers.schedule import router as schedule_router
from src.routers.standings import router as standings_router
from src.routers.team_events import router as team_events_router
from src.routers.team_ratings import router as team_ratings_router
from src.routers.transactions import router as transactions_router
from src.routers.twitter_comments import router as twitter_comments_router
from src.routers.users import router as users_router

from src.routers.ml.predict import router as housing_fake_router
from src.utils import templates

provider = TracerProvider()
processor = BatchSpanProcessor(OTLPSpanExporter())
provider.add_span_processor(processor)
trace.set_tracer_provider(provider)
tracer = trace.get_tracer(__name__)

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.add_middleware(BaseHTTPMiddleware, dispatch=log_middleware)
app.add_middleware(
    SessionMiddleware,
    secret_key=os.environ.get("API_KEY"),
    https_only=True,
)
app.include_router(admin_router)
app.include_router(admin_feedback_router)
app.include_router(auth_router)
app.include_router(bets_router)
app.include_router(feature_flags_router)
app.include_router(feedback_router)
app.include_router(game_types_router)
app.include_router(gmail_auth_router)
app.include_router(help_page_router)
app.include_router(housing_fake_router)
app.include_router(incidents_router)
app.include_router(injuries_router)
app.include_router(login_router)
app.include_router(health_router)
app.include_router(past_bets_router)
app.include_router(player_stats_router)
app.include_router(predictions_router)
app.include_router(reddit_comments_router)
app.include_router(reporting_router)
app.include_router(settings_router)
app.include_router(schedule_router)
app.include_router(standings_router)
app.include_router(team_events_router)
app.include_router(team_ratings_router)
app.include_router(transactions_router)
app.include_router(twitter_comments_router)
app.include_router(users_router)


app.mount("/static", StaticFiles(directory="static"), name="static")
FastAPIInstrumentor.instrument_app(app)
RequestsInstrumentor().instrument()
# Instrumentator().instrument(app).expose(app)
# if i ever swap to ecs ;-)

handler = Mangum(app)


@app.on_event("startup")
async def startup() -> None:
    redis = aioredis.from_url(url=os.environ.get("REDIS_URL"))
    FastAPICache.init(RedisBackend(redis), prefix="fastapi-cache")


@app.get("/", response_class=HTMLResponse)
def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.exception_handler(404)
async def custom_404_handler(request: Request, __):
    return templates.TemplateResponse("404.html", {"request": request}, status_code=404)


# useful for session middleware testing
# @app.get("/a")
# async def session_set(request: Request):
#     request.session["my_var"] = "1234"
#     logging.info(f"session a is {request.session}")
#     return "ok"


# @app.get("/b")
# async def session_info(request: Request):
#     my_var = request.session.get("my_var", None)
#     logging.info(f"session b is {request.session}")
#     return my_var
