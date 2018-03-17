help:
	@echo 'Makefile for managing web application                    '
	@echo '                                                         '
	@echo 'Usage:                                                   '
	@echo ' make build      build images                            '
	@echo ' make up         creates containers and starts service   '
	@echo ' make start      starts service containers               '
	@echo ' make stop       stops service containers                '
	@echo ' make down       stops service and removes containers    '
	@echo '                                                         '
	@echo ' make migrate    run migrations                          '
	@echo ' make test       run tests                               '
	@echo ' make test_cov   run tests with coverage.py              '
	@echo '                                                         '
	@echo ' make attach     attach to process inside service        '
	@echo ' make logs       see container logs                      '
	@echo ' make shell      connect to container in new bash shell  '
	@echo '                                                         '

build:
	docker-compose build

up:
	docker-compose up -d app db

start:
	docker-compose start app db

stop:
	docker-compose stop

down:
	docker-compose down

attach: ## Attach to app container
	docker attach myapp

logs:
	docker logs -f myapp

shell: ## Shell into app container
	docker exec -it myapp /bin/bash

migrate: up
	echo 'Need to add migrations'

test: migrate
	docker-compose exec app pytest

test_cov: migrate
	docker-compose exec app pytest --verbose --cov

test_cov_view: migrate
	docker-compose exec app pytest --cov --cov-report html && open ./htmlcov/index.html

test_fast: ## Can pass in parameters using p=''
	docker-compose exec app pytest $(p)

# Flake 8
# options: http://flake8.pycqa.org/en/latest/user/options.html
# codes: http://flake8.pycqa.org/en/latest/user/error-codes.html
lint: up
	docker-compose exec app flake8