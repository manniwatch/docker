FROM node:16.8-alpine
# Generic Labels
LABEL org.opencontainers.image.title="Manniwatch"
LABEL org.opencontainers.image.description="Manniwatch Docker Image"

ARG MW_DEFAULT_ENDPOINT="undefined"
ENV MW_ENDPOINT $MW_DEFAULT_ENDPOINT
ENV MW_PORT=3000

WORKDIR /usr/src/app
COPY --chown=node:node package*.json tsconfig*.json ./
COPY --chown=node:node ./src ./src

RUN npm ci && \
    npm run build && \
    npm prune --production && \
    npm ci --production && \
    npm cache clean --force

ENV NODE_ENV="production"
EXPOSE 3000
RUN echo "Building with Endpoint ${MW_ENDPOINT} and Port ${MW_PORT}"

USER node
ENTRYPOINT ["node", "./dist/index.js"]
CMD [ "api" ]
