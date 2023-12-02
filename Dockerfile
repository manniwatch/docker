# Get base container
FROM node:21.3-alpine AS apline_container

# Build server
FROM apline_container AS build_server

ARG MW_DEFAULT_ENDPOINT="undefined"
ENV MW_ENDPOINT $MW_DEFAULT_ENDPOINT
ENV MW_PORT=3000

WORKDIR /usr/src/app
COPY --chown=node:node package*.json tsconfig*.json ./
COPY --chown=node:node ./src ./src

RUN echo "Building with Endpoint ${MW_ENDPOINT} and Port ${MW_PORT}"
RUN npm ci
RUN npm run build

# Build Final Image
FROM apline_container

LABEL org.opencontainers.image.title="Manniwatch"
LABEL org.opencontainers.image.description="Manniwatch Docker Image"

ARG MW_DEFAULT_ENDPOINT="undefined"
ENV MW_ENDPOINT $MW_DEFAULT_ENDPOINT
ENV MW_PORT=3000

WORKDIR /usr/src/app
COPY --chown=node:node package*.json tsconfig*.json ./
COPY --chown=node:node ./src ./src
COPY --from=build_server --chown=node:node /usr/src/app/dist ./dist

ENV NODE_ENV="production"
RUN npm ci --production && \
    npm cache clean --force

EXPOSE 3000

USER node
ENTRYPOINT ["node", "./dist/index.js"]
CMD [ "api" ]
