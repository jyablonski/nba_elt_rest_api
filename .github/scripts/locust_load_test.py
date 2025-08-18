from locust import HttpUser, task, between, events, LoadTestShape
import os
from random import randint

P95_MS = int(os.getenv("SLO_P95_MS", "25"))
P99_MS = int(os.getenv("SLO_P99_MS", "50"))
MAX_ERROR_RATE = float(os.getenv("SLO_MAX_ERROR_RATE", "0.01"))
AUTH_TOKEN = os.getenv("AUTH_TOKEN", "")
COMMON_HEADERS = {"Authorization": f"Bearer {AUTH_TOKEN}"} if AUTH_TOKEN else {}


class ApiUser(HttpUser):
    wait_time = between(0.05, 0.2)

    def on_start(self):
        self.client.post(
            "/v1/login", json={"username": "test1", "password": "password"}
        )

    @task(5)
    def reddit_comments(self):
        page = randint(1, 5)
        limit = randint(1, 50)
        self.client.get(
            f"/v1/social/reddit/comments?page={page}&limit={limit}",
            headers=COMMON_HEADERS,
            name="GET /v1/social/reddit/comments",
        )

    @task(2)
    def reddit_comments_filter(self):
        filters = ["nba", "jokic", "as", "playoffs"]
        filter_value = filters[randint(0, len(filters) - 1)]
        page = randint(1, 3)
        limit = randint(1, 20)
        self.client.get(
            f"/v1/social/reddit/comments?filter={filter_value}&page={page}&limit={limit}",
            headers=COMMON_HEADERS,
            name="GET /v1/social/reddit/comments?filter",
        )

    @task(3)
    def league_game_types(self):
        self.client.get(
            "/v1/league/game_types",
            headers=COMMON_HEADERS,
            name="GET /v1/league/game_types",
        )

    @task(3)
    def team_game_types(self):
        teams = ["IND", "LAL", "BOS", "GSW"]
        team = teams[randint(0, len(teams) - 1)]
        self.client.get(
            f"/v1/teams/{team}/game_types",
            headers=COMMON_HEADERS,
            name="GET /v1/teams/{team}/game_types",
        )

    @task(4)
    def league_schedule(self):
        dates = ["2023-01-01", "2023-12-15", "2024-01-01"]
        date = dates[randint(0, len(dates) - 1)]
        self.client.get(
            f"/v1/league/schedule?date={date}",
            headers=COMMON_HEADERS,
            name="GET /v1/league/schedule",
        )

    @task(1)
    def health(self):
        self.client.get("/health", name="GET /health")


class StepLoadShape(LoadTestShape):
    """
    Linear ramp-up + hold + stop.
    """

    min_users = 5
    max_users = 10
    ramp_time = 15  # seconds to reach max_users
    hold_time = 45  # hold max load so total run ~60s
    spawn_rate = 100  # users per second

    def tick(self):
        run_time = self.get_run_time()
        if run_time < self.ramp_time:
            # ramp-up
            users = self.min_users + (self.max_users - self.min_users) * (
                run_time / self.ramp_time
            )
            return int(users), self.spawn_rate
        elif run_time < self.ramp_time + self.hold_time:
            # hold max load
            return self.max_users, self.spawn_rate
        else:
            # stop the test
            return None


# ---- CI SLO check ----
@events.quitting.add_listener
def check_slo(environment, **kwargs):
    stats = environment.stats.total
    total_reqs = max(1, stats.num_requests)
    errors = stats.num_failures
    error_rate = errors / total_reqs
    p95 = stats.get_response_time_percentile(0.95)
    p99 = stats.get_response_time_percentile(0.99)

    print("\n--- SLO Check ---")
    print(f"Total reqs: {total_reqs}")
    print(f"Error rate: {error_rate:.4f} (SLO <= {MAX_ERROR_RATE})")
    print(f"P95: {p95:.0f} ms (SLO < {P95_MS} ms)")
    print(f"P99: {p99:.0f} ms (SLO < {P99_MS} ms)")

    failed = (error_rate > MAX_ERROR_RATE) or (p95 >= P95_MS) or (p99 >= P99_MS)
    environment.process_exit_code = 1 if failed else 0
