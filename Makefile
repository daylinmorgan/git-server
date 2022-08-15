.PHONY: lint
lint:
	black *.py
	prettier -w ./soft-serve.config.json

.PHONY: update-soft-serve
update-soft-serve:
	sudo ./update-soft-serve-repos.py
	docker compose restart soft-serve
