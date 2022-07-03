mongo:
	docker run -p 27017:27017 \
	-d \
	--rm \
	--name mongodb \
	--network notes-net \
	--env-file ./config/development.env \
	-v mongo-data:/data/db \
	mongo

backend:
	docker run -p 5001:5001 \
	--rm \
	-d \
	--name notes-backend \
	--network notes-net \
	-v /Users/sergejmetelskij/Documents/GitHub/docker-mern/server:/app \
	-v /app/node_modules \
	--env-file ./config/development.env \
	notes-backend

frontend:
	docker run -p 3000:3000 \
	-d \
	--rm \
	--name notes-frontend \
	-v /Users/sergejmetelskij/Documents/GitHub/docker-mern/client/src:/app/src \
	notes-frontend

stop:
	docker stop mongodb notes-frontend notes-backend

dev:
	docker-compose -f docker-compose.yml up -d

build:
	docker-compose -f docker-compose.production.yml up

down:
	docker-compose down

# SSH (need to add actual server IP)

SSH_STRING:=root@31.184.254.152

ssh:
	ssh $(SSH_STRING)

copy-files
	scp -r ./* $(SSH_STRING):/root/app