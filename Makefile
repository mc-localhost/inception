NAME=inception
COMPOSE_FILE=./srcs/docker-compose.yml

up:
	mkdir -p /home/vvasiuko/data/database
	mkdir -p /home/vvasiuko/data/web
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
	rm -rf /home/vvasiuko/data/database 
	rm -rf /home/vvasiuko/data/web
	docker system prune -a -f

re: clean up

.PHONY: up down restart logs ps clean re
