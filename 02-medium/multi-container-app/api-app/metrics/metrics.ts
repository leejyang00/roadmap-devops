import * as client from "prom-client";

// const register = new client.Registry()
client.collectDefaultMetrics();

// create custom counter to track HTTP requests
const httpRequestsTotal = new client.Counter({
    name: 'http_requests_total',
    help: 'Total number of HTTP requests',
    labelNames: ['method', 'route']
})
// register.registerMetric(httpRequestsTotal)

// create a custom counter for todos created
const todosCreatedTotal = new client.Counter({
    name: 'todos_created_total',
    help: 'Total number of todos created'
})

// Create a histogram to measure todo creation duration in seconds
const todoCreationDuration = new client.Histogram({
  name: 'todo_creation_duration_seconds',
  help: 'Time taken to create a todo in seconds',
  buckets: [0.1, 0.5, 1, 2, 5] // Customize buckets as needed
});

export {
    httpRequestsTotal,
    todosCreatedTotal,
    todoCreationDuration
}

export const register = client.register;
