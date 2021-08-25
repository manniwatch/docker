FROM node:16.7-alpine
# Generic Labels
LABEL org.opencontainers.image.title="Manniwatch"
LABEL org.opencontainers.image.description="Manniwatch Docker Image"

ARG MW_DEFAULT_ENDPOINT="undefined"
ARG MW_DEFAULT_PORT=3000
ENV MW_ENDPOINT $MW_DEFAULT_ENDPOINT
ENV MW_PORT $MW_DEFAULT_PORT

WORKDIR /usr/src/app
COPY package*.json tsconfig*.json ./
COPY ./src ./src

RUN npm ci && \
    npm run build && \
    npm prune --production && \
    npm ci --production && \
    npm cache clean --force

EXPOSE 3000
RUN echo "Building with Endpoint ${MW_ENDPOINT} and Port ${MW_PORT}"

USER node
ENTRYPOINT ["node", "./dist/index.js"]
CMD [ "api" ]
