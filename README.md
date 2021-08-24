# Manniwatch Docker

![Docker Image Version (latest semver)](https://img.shields.io/docker/v/manniwatch/manniwatch?logo=docker&sort=semver) ![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/manniwatch/manniwatch?logo=docker&sort=semver)

This repository is used to build and publish the [Docker Image](https://hub.docker.com/r/manniwatch/manniwatch) for Manniwatch.

# Usage

### Configure during build
You either can set the Endpoint information during build time via build args:
```docker build -t manniwatch --build-arg MW_DEFAULT_ENDPOINT=test.domain ./```

| Variable | Default | Description |
| -------- | ------- | ---------- |
| MW_DEFAULT_ENDPOINT | undefined | Endpoint to query traffic data from |
| MW_DEFAULT_PORT | 3000 | Port to use |

### Configure runtime
```docker run --env MW_ENDPOINT="test2.domain" -it manniwatch```

Options are:
| Variable | Default | Description |
| -------- | ------- | ----------- |
| MW_ENDPOINT | build-arg MW_DEFAULT_ENDPOINT | Endpoint to query traffic data from |
| MW_PORT | build-arg MW_DEFAULT_PORT | Port to use |


### Running

You can either run in `api only` or `full` mode. One does only provide the rest api while the other provides the web client too. Default is `api`

```
docker run -it manniwatch api
```
If you want to run in full mode you will have to mount the client-ng files to the directory `/manniwatch/client`.
```
docker run -it manniwatch full
``` 
