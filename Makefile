.PHONY: run
run:
	if [ ! -e ".env.local" ]; then\
		cp .env.dev .env.local; \
	fi
	docker-compose --env-file=./.env.local up -d
	echo "Service is running on http://localhost:9001"

.PHONY: install
install:
	docker compose exec --user="php" -T devbox-service bin/warmup
	docker-compose exec --user="php" -T devbox-service composer install

.PHONY: stop
stop:
	docker-compose stop

.PHONY: enter
enter:
	docker-compose  exec --user="php" devbox-service /bin/sh

.PHONY: enter-as-root
enter-as-root:
	docker-compose  exec --user="root" devbox-service /bin/sh

.PHONY: test
test:
	docker-compose  exec --user="php" -T devbox-service /bin/sh -c 'APP_ENV="test" ./bin/phpunit --testdox'

.PHONY: destroy
destroy:
	docker-compose down --rmi local

cc: clear-cache
.PHONY: clear-cache
clear-cache:
	@docker-compose exec devbox-service /bin/sh -c 'rm -rf var/cache/*'

.PHONY: clear-cache
logs:
	docker compose logs -f
