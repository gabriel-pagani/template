build-system:
	@if [ "$(scope)" = "frontend" ] || [ -z "$(scope)" ]; then \
		cd frontend/ && npm install && npm run build; \
	fi

	@if [ "$(scope)" = "backend" ] || [ -z "$(scope)" ]; then \
		cd deploy/ && docker compose up -d --build; \
	fi

start-system:
	@cd deploy/ && \
	docker compose up -d

stop-system:
	@cd deploy/ && \
	docker compose down

restart-system:
	@cd deploy/ && \
	docker compose restart

clean-system:
	@cd deploy/ && \
	docker compose down -v && \
	docker system prune -a --volumes --force && \
    cd .. && sudo rm -rf backend/build/ database/ frontend/node_modules/ deploy/certbot/
