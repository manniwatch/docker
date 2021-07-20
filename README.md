# Manniwatch Docker

This repository is used to build and publish the Docker Image for Manniwatch.

# Usage

### Configure during build
You either can set the Endpoint information during build time via build args:
```docker build -t manniwatch --build-arg MW_DEFAULT_ENDPOINT=test.domain ./```

| Variable | Default | Description |
| -------- | ------- | ---------- |
| MW_DEFAULT_ENDPOINT | undefined | Endpoint to query traffic data from |
| MW_DEFAULT_PORT | 3000 | Port to use |

### Configure runtime
```docker run --env MW_ENDPOINT=test2.domain ./```

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
```
docker run -it manniwatch full
``` 
