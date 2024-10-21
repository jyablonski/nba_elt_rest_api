FROM python:3.12-slim AS base

ENV POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_NO_INTERACTION=1

FROM base AS python-deps

COPY pyproject.toml poetry.lock ./
COPY docker/install_packages.sh ./

RUN ./install_packages.sh && \
    pip install poetry && \
    poetry install --no-root

FROM base AS runtime

COPY --from=python-deps ./.venv ./.venv
ENV PATH="/.venv/bin:$PATH"

RUN useradd --create-home appuser
USER appuser
WORKDIR /home/appuser

COPY config.yaml ./
COPY src/ ./src/
COPY static/ ./static/
COPY templates/ ./templates/

EXPOSE 8080

CMD ["uvicorn", "src.server:app", "--reload", "--host", "0.0.0.0", "--port", "8080"]
