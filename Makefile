.PHONY: lint
lint:
	black soft/config/*.py
	prettier -w ./soft/config/soft-serve.config.json

.PHONY: update-soft-serve
update-soft-serve: soft-repos
	docker compose restart soft-serve

.PHONY: soft-repos
soft-repos:
	./soft/config/update-soft-serve-repos.py

