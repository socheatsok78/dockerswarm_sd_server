# About

Using docker stack deploy to deploy the `dockerswarm_sd_server` service to Docker Swarm.

## Deploy

Run the following command to deploy the `dockerswarm_sd_server` service to Docker Swarm.

```bash
docker stack deploy -c docker-compose.yml dockerswarm
```

## Remove

```bash
docker stack rm dockerswarm
```
