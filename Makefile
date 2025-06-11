NAME=inception
COMPOSE_FILE=./srcs/docker-compose.yml

up:
	mkdir -p ./srcs/data/database
	mkdir -p ./srcs/data/web
	docker compose -f $(COMPOSE_FILE) up --build -d

down:
	docker compose -f $(COMPOSE_FILE) down

restart:
	docker compose -f $(COMPOSE_FILE) down
	docker compose -f $(COMPOSE_FILE) up --build -d

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

ps:
	docker compose -f $(COMPOSE_FILE) ps

clean:
	docker-compose -f $(COMPOSE_FILE) down -v --remove-orphans
	rm -rf ./srcs/data/database 
	rm -rf ./srcs/data/web

re: clean up

.PHONY: up down restart logs ps clean re
