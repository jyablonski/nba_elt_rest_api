import os

from fastapi import FastAPI, Request
from fastapi_cache import FastAPICache
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

from src.models.users import Base
from src.database import engine
from src.middleware import log_middleware
from src.utils import templates
from src.routers.pages import pages_router
from src.routers.v1 import v1_router

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
app.include_router(v1_router, prefix="/v1")
app.include_router(pages_router)

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
