from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from mangum import Mangum
from opentelemetry import trace
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.instrumentation.requests import RequestsInstrumentor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor

from .models import Base
from .database import engine
from .routers import (
    auth,
    bets,
    feedback,
    game_types,
    injuries,
    login,
    past_bets,
    predictions,
    reddit_comments,
    schedule,
    scorers,
    standings,
    team_ratings,
    transactions,
    twitter_comments,
    users,
)
from .utils import templates

provider = TracerProvider()
processor = BatchSpanProcessor(OTLPSpanExporter())
provider.add_span_processor(processor)
trace.set_tracer_provider(provider)
tracer = trace.get_tracer(__name__)

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(auth.router)
app.include_router(bets.router)
app.include_router(feedback.router)
app.include_router(game_types.router)
app.include_router(injuries.router)
app.include_router(login.router)
app.include_router(past_bets.router)
app.include_router(predictions.router)
app.include_router(reddit_comments.router)
app.include_router(schedule.router)
app.include_router(scorers.router)
app.include_router(standings.router)
app.include_router(team_ratings.router)
app.include_router(transactions.router)
app.include_router(twitter_comments.router)
app.include_router(users.router)

# app.mount(
#     "/static", AuthStaticFiles(directory="static"), name="static",
# )
app.mount("/static", StaticFiles(directory="static"), name="static")
FastAPIInstrumentor.instrument_app(app)
RequestsInstrumentor().instrument()
handler = Mangum(app)


@app.get("/", response_class=HTMLResponse)
def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.exception_handler(404)
async def custom_404_handler(request: Request, __):
    return templates.TemplateResponse("404.html", {"request": request}, status_code=404)
