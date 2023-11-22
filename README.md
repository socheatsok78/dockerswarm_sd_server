# About
A simple server provide proxying to Docker Engine API for using with Prometheus/Promtail ("dockerswarm_sd_configs" scrape_configs)

## Overview
![diagram](https://github.com/socheatsok78/dockerswarm_sd_server/assets/4363857/39958a43-b9b0-4c01-ab11-c755917e3d54)

## Endpoints

The `dockerswarm_sd_server` provide a simple HTTP server that proxying to Docker Engine API. It has a limited functionality, but it's enough for using with Prometheus/Promtail.

The `dockerswarm_sd_server` exposed the following endpoints:

- `/_ping` - This is a dummy endpoint you can use to test if the server is accessible.
- `/v*/tasks` - A task is a container running on a swarm. It is the atomic scheduling unit of swarm.
- `/v*/services` - Services are the definitions of tasks to run on a swarm.
- `/v*/nodes` - Nodes are instances of the Engine participating in a swarm.
- `/v*/networks` - Networks are user-defined networks that containers can be attached to.

See https://docs.docker.com/engine/api/ for more details.
