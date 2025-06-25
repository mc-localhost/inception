NAME=inception
COMPOSE_FILE=./srcs/docker-compose.yml
DATA_DIR = /home/vvasiuko/data

up:
	mkdir -p ${DATA_DIR}/database
	mkdir -p ${DATA_DIR}/web
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
	docker compose -f $(COMPOSE_FILE) down -v --remove-orphans
	rm -rf ${DATA_DIR}
	docker system prune --volumes -af

re: clean up

.PHONY: up down restart logs ps clean re
