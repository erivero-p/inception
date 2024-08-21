# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: erivero- <erivero-@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/01 10:39:50 by erivero-          #+#    #+#              #
#    Updated: 2024/08/21 12:03:43 by erivero-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
		@sudo mkdir -p ~/data/mariadb
		@sudo mkdir -p ~/data/wordpress
		@docker compose -f ./srcs/docker-compose.yml up

re:
		@rm -rf ~/data/mariadb/*
		@rm -rf ~/data/wordpress/*
		@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
		@docker compose -f ./srcs/docker-compose.yml down

clean: down
		@rm -rf ~/data/mariadb
		@rm -rf ~/data/wordpress

fclean:
		@docker stop $$(docker ps -qa)
		@docker system prune --all --force --volumes
		@docker network prune --force
		@docker volume prune --force
		@docker volume rm $$(docker volume ls -qf dangling=true)
		@rm -rf ~/data/wordpress
		@rm -rf ~/data/mariadb

logs:
		@docker compose -f ./srcs/docker-compose.yml logs

.PHONY: all re down clean fclean logs