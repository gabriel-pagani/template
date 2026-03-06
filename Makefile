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

create-superuser:
	@cd deploy/ && \
	docker compose exec app python manage.py shell -c "from app.models import Users; Users.objects.filter(username='admin').exists() or Users.objects.create_superuser(username='admin', password='1234')"

container-terminal:
	@cd deploy/ && \
	docker compose exec $(container) sh

containers-logs:
	@cd deploy/ && \
	docker compose logs -f $(container)
