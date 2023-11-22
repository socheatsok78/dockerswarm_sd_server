# About
A simple server provide proxying to Docker Engine API for using with **Prometheus/Promtail** ("dockerswarm_sd_configs" scrape_configs)

## Overview
![diagram](https://github.com/socheatsok78/dockerswarm_sd_server/assets/4363857/39958a43-b9b0-4c01-ab11-c755917e3d54)

## Endpoints

The `dockerswarm_sd_server` provide a simple HTTP server that proxying to Docker Engine API. It has a limited functionality, but it's enough for using with **Prometheus/Promtail**.

The `dockerswarm_sd_server` exposed the following endpoints:

- `/_ping` - This is a dummy endpoint you can use to test if the server is accessible.
- `/v*/tasks` - A task is a container running on a swarm.
- `/v*/services` - Services are the definitions of tasks to run on a swarm.
- `/v*/nodes` - Nodes are instances of the Engine participating in a swarm.
- `/v*/networks` - Networks are user-defined networks that containers can be attached to.

See https://docs.docker.com/engine/api/ for more details.

## Usage and Deployment

The following section will guide you through the process of deploying the `dockerswarm_sd_server` service to Docker Swarm.

### Create a `dockerswarm_sd_network` network

The `dockerswarm_sd_server` service must be deployed to the `dockerswarm_sd_network` network. The `dockerswarm_sd_server` service will be discoverable by other services in the same network. e.g: **Prometheus/Promtail**.

```bash
docker network create --scope swarm --driver overlay --attachable dockerswarm_sd_network
```

### Deploying the `dockerswarm_sd_server` service to Docker Swarm

```bash
docker service create \
        --detach=true \
        --name dockerswarm_sd_server \
        --network dockerswarm_sd_network \
        --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock,readonly=true \
        --constraint node.role==manager \
        --restart-condition any \
        --restart-max-attempts 3 \
        --restart-window 60s \
        --update-delay 60s \
        --update-parallelism 1 \
        --update-monitor 60s \
        --update-failure-action rollback \
        --update-order stop-first \
        --with-registry-auth \
    socheatsok78/dockerswarm_sd_server:main
```

### Remove the `dockerswarm_sd_server` service from Docker Swarm

> [!WARNING]
> Before removing the `dockerswarm_sd_server` service, make sure you have removed all the services that are using the `dockerswarm_sd_server` service.

```bash
docker service rm dockerswarm_sd_server
```

## Configure Prometheus/Promtail

To configure Prometheus/Promtail to scrape the `dockerswarm_sd_server` service, you need to use `dockerswarm_sd_server` as the `host` value in the `dockerswarm_sd_configs` scrape_configs.

```yaml
- job_name: dockerswarm
    dockerswarm_sd_configs:
      - host: http://dockerswarm_sd_server:9093
        refresh_interval: 5s
        role: tasks
```

## License

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.

See [LICENSE](LICENSE) for more information.
