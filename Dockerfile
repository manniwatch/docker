FROM node:16.8-alpine AS build

ARG MW_DEFAULT_ENDPOINT="undefined"
ENV MW_ENDPOINT $MW_DEFAULT_ENDPOINT
ENV MW_PORT=3000

WORKDIR /usr/src/app
COPY --chown=node:node package*.json tsconfig*.json ./
COPY --chown=node:node ./src ./src

RUN echo "Building with Endpoint ${MW_ENDPOINT} and Port ${MW_PORT}"
RUN npm ci
RUN npm run build


FROM node:16.8-alpine

LABEL org.opencontainers.image.title="Manniwatch"
LABEL org.opencontainers.image.description="Manniwatch Docker Image"

ARG MW_DEFAULT_ENDPOINT="undefined"
ENV MW_ENDPOINT $MW_DEFAULT_ENDPOINT
ENV MW_PORT=3000

WORKDIR /usr/src/app
COPY --chown=node:node package*.json tsconfig*.json ./
COPY --chown=node:node ./src ./src
COPY --from=build --chown=node:node /usr/src/app/dist ./dist

ENV NODE_ENV="production"
RUN npm ci --production && \
    npm cache clean --force

EXPOSE 3000
RUN echo "Building with Endpoint ${MW_ENDPOINT} and Port ${MW_PORT}"

USER node
ENTRYPOINT ["node", "./dist/index.js"]
CMD [ "api" ]
