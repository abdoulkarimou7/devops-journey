# Task Manager API

A simple REST API for managing tasks, built with Express and PostgreSQL, containerized with Docker and orchestrated with Docker Compose.

## Stack
- Node.js / Express
- PostgreSQL
- Docker & Docker Compose
- Jest + Supertest (testing)
- GitHub Actions (CI)

## Routes
- `GET /tasks` — list all tasks
- `POST /tasks` — create a task
- `PUT /tasks/:id` — mark a task as done
- `DELETE /tasks/:id` — delete a task

## Run locally
\`\`\`bash
docker-compose up --build
\`\`\`

## Run tests
\`\`\`bash
npm test
\`\`\`
