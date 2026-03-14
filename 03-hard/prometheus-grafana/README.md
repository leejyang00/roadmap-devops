# Unified Observability Stack

A comprehensive monitoring and logging system that integrates Prometheus, Alertmanager, Grafana, Loki, and Promtail to provide real-time insights into your server’s performance, resource utilization, and overall health.

> This project is created as part of the [Prometheus and Grafana](https://roadmap.sh/projects/monitoring) project.

## Overview

We're assuming that we have launch `api-app` from `02-medium` `multi-container-app` `api-app` that runs a backend service, mongodb and nginx. It handles redirects to `myapp.local` with `/todos` with CRUD commands. 

Sample of a POST request:
```
{
    "title": "nuchada for",
    "description": "dancing on the rain",
    "completed": false
}
```

During testing, it was launched into a MultiPass VM created in my MacBook local machine using this:
```
multipass launch --name multi-container --cpus 2 --memory 4G --disk 10G
```

## Project

This project sets up a full observability stack:
- Exporters:
    Collects and exports system metrics along with metrics from additional additional services like Nginx, MongoDB, and application-specific metrics
- Prometheus:
    Scrapes metrics from various endpoints, evaluates alert rules, and retain data for analysis

last bit:
- setup application monitoring prom-client and custom metrics out
- setup promtail for scrapping docker logs, and store them in Loki


promtail has reached End of Life (EOL) March 02, 2026, no future support or updates. Future feature developments will occur in Grafana Alloy

docker exec prometheus-container wget -qO- http://api-app:3000/metrics
docker network inspect monitoring_link --format '{{range .Containers}}{{.Name}} {{end}}'
docker compose up -d --force-recreate
docker compose up -d --build prometheus-service