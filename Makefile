build:
	docker-compose build

up:
	docker-compose up -d

up-non-daemon:
	docker-compose up

down:
	docker-compose down

start:
	docker-compose start

stop:
	docker-compose stop

restart:
	docker-compose stop && docker-compose start

shell-nginx:
	docker exec -ti nginx /bin/sh

shell-web:
	docker exec -ti django /bin/sh

shell-db:
	docker exec -ti postgres /bin/sh

log-nginx:
	docker-compose logs nginx  

log-web:
	docker-compose logs web  

log-db:
	docker-compose logs db

collectstatic:
	docker exec django /bin/sh -c "python manage.py collectstatic --noinput"

prune:
	docker-compose down && docker system prune -a -f && docker system prune --volumes -f

postgres-ip:
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' postgres

postgres-start:
	docker-compose build db && docker-compose up -d db