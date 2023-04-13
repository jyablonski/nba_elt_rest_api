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
	@docker-compose -f docker/docker-compose.yml up -d

.PHONY: stop-postgres
stop-postgres:
	@docker-compose -f docker/docker-compose.yml down

.PHONY: test
test:
	@pytest -v