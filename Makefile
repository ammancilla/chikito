build:
	docker build . -t chikito

setup:
	docker image inspect chikito &>/dev/null || make build
	docker volume inspect chikito_database &>/dev/null || docker volume create chikito_database
	docker-compose -p chikito run --rm app bundle exec rails db:prepare db:test:prepare
stop:
	docker-compose -p chikito stop

start: stop
	docker-compose -p chikito up --remove-orphans

shell:
	docker-compose -p chikito exec app bash || docker-compose -p chikito run --rm app bash

console:
	docker-compose -p chikito exec app rails c || docker-compose -p chikito run --rm app rails c

tests:
	docker-compose -p chikito run --rm app bash -c "RAILS_ENV=test rspec"

clean: stop
	docker-compose -p chikito down
	docker volume rm chikito_database
