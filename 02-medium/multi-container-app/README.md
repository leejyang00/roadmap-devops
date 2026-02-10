# Multi-Container Application

link: https://roadmap.sh/projects/multi-container-service
- will be using this project for monitoring (Prometheus, Grafana, Loki and PromTail) in HARD section

## Requirements:
Create a simple unauthenticated Node.js API service for creating a simple todo list. The API should have the following endpoints:

- GET /todos — get all todos

- POST /todos — create a new todo

- GET /todos/:id — get a single todo by id

- PUT /todos/:id — update a single todo by id

- DELETE /todos/:id — delete a single todo by id

The API should connect to MongoDB to store the todo items. You can use Express for the API and Mongoose to connect to MongoDB. You can use nodemon to automatically restart the server when the source code changes.

Requirement #1 - Dockerize the API
You are required to dockerize the API and have a docker-compose.yml file which will spin up a MongoDB container and the API container. If everything works, you should be able to access the API via http://localhost:3000 and the todos should be saved to the MongoDB container. Data should be persisted when the containers are stopped and started.


