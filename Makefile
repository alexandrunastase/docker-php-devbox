.PHONY: run
run:
	@if [ ! -e ".env.local" ]; then\
		cp .env .env.local; \
	fi
	@docker-compose up -d
	@echo "Service is running on http://localhost:9001"

.PHONY: install
install:
	@docker-compose exec --user="php" -T devbox-service composer install

.PHONY: stop
stop:
	@docker-compose stop

.PHONY: enter
enter:
	@docker-compose exec --user="php" devbox-service /bin/sh

.PHONY: enter-as-root
enter-as-root:
	@docker-compose exec --user="root" devbox-service /bin/sh

.PHONY: test
test:
	@docker-compose exec --user="php" -T devbox-service /bin/sh -c 'APP_ENV="test" ./bin/phpunit --testdox'

.PHONY: destroy
destroy:
	@docker-compose down --rmi local

