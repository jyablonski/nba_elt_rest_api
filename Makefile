.PHONY: venv
venv:
	@pipenv shell

.PHONY: serve
serve:
	@uvicorn src.main:app --reload

.PHONY: install-packages-r
install-packages-r:
	@pip install -t lib -r requirements.txt

.PHONY: zip
zip:
	@(cd lib; zip ../lambda_function.zip -r .)
	@(zip lambda_function.zip -r src/)
	@(zip lambda_function.zip -r static/)
	@(zip lambda_function.zip -r templates/)
	@(zip lambda_function.zip -r config.yaml)

.PHONY: bump-patch
bump-patch:
	@bump2version patch
	@git push --tags
	@git push

.PHONY: bump-minor
bump-minor:
	@bump2version minor
	@git push --tags
	@git push

.PHONY: bump-major
bump-major:
	@bump2version major
	@git push --tags
	@git push

.PHONY: start-postgres
start-postgres:
	@docker compose -f docker/docker-compose-postgres.yml up --build -d

.PHONY: stop-postgres
stop-postgres:
	@docker compose -f docker/docker-compose-postgres.yml down

.PHONY: docker-build-local
docker-build-local:
	@docker compose -f docker/docker-compose-local.yml build

.PHONY: up
up:
	@docker compose -f docker/docker-compose-local.yml up -d

.PHONY: down
down:
	@docker compose -f docker/docker-compose-local.yml down

.PHONY: ci-test
ci-test:
	@make stop-postgres
	@make start-postgres
	@sleep 1
	@uv run pytest --cov-report term --cov-report xml:coverage.xml --cov=src --color=yes
	@make stop-postgres

.PHONY: follow-logs
follow-logs:
	@docker compose -f docker/docker-compose-local.yml logs rest_api --follow

.PHONY: test
test:
	@docker compose -f docker/docker-compose-test.yml down
	@docker compose -f docker/docker-compose-test.yml up --exit-code-from rest_api_test_runner

# the `-` prefix makes it ignore the errors basically and continue running the rest of the checks
.PHONY: lint
lint:
	@echo Checking Black --------------
	@uv run black src/
	@echo Checking Ruff ---------------
	-@uv run ruff check .
	@echo Checking MyPy ---------------
	-@uv run mypy src/
