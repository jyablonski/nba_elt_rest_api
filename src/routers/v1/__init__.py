from fastapi import APIRouter

from .admin import router as admin_router
from .auth import router as auth_router
from .bets import router as bets_router
from .feature_flags import router as feature_flags_router
from .feedback import router as feedback_router
from .game_types import router as game_types_router
from .gmail_auth import router as gmail_auth_router
from .incidents import router as incidents_router
from .injuries import router as injuries_router
from .login import router as login_router
from .ml_predict_fake import router as ml_predict_fake_router
from .past_bets import router as past_bets_router
from .player_stats import router as player_stats_router
from .predictions import router as predictions_router
from .reddit_comments import router as reddit_comments_router
from .reporting import router as reporting_router
from .schedule import router as schedule_router
from .settings import router as settings_router
from .standings import router as standings_router
from .team_events import router as team_events_router
from .team_ratings import router as team_ratings_router
from .transactions import router as transactions_router
from .twitter_comments import router as twitter_comments_router
from .users import router as users_router

v1_router = APIRouter()

v1_router.include_router(admin_router, tags=["admin"])
v1_router.include_router(auth_router, tags=["auth"])
v1_router.include_router(bets_router, tags=["bets"])
v1_router.include_router(feature_flags_router, tags=["feature-flags"])
v1_router.include_router(feedback_router, tags=["feedback"])
v1_router.include_router(game_types_router, tags=["game-types"])
v1_router.include_router(gmail_auth_router, tags=["gmail-auth"])
v1_router.include_router(incidents_router, tags=["incidents"])
v1_router.include_router(injuries_router, tags=["injuries"])
v1_router.include_router(login_router, tags=["login"])
v1_router.include_router(ml_predict_fake_router, tags=["ml-predict-fake"])
v1_router.include_router(past_bets_router, tags=["past-bets"])
v1_router.include_router(player_stats_router, tags=["player-stats"])
v1_router.include_router(predictions_router, tags=["predictions"])
v1_router.include_router(reddit_comments_router, tags=["reddit-comments"])
v1_router.include_router(reporting_router, tags=["reporting"])
v1_router.include_router(schedule_router, tags=["schedule"])
v1_router.include_router(settings_router, tags=["settings"])
v1_router.include_router(standings_router, tags=["standings"])
v1_router.include_router(team_events_router, tags=["team-events"])
v1_router.include_router(team_ratings_router, tags=["team-ratings"])
v1_router.include_router(transactions_router, tags=["transactions"])
v1_router.include_router(twitter_comments_router, tags=["twitter-comments"])
v1_router.include_router(users_router, tags=["users"])
