FROM node:14

ENV MW_ENDPOINT="undefined"
ENV MW_PORT=3000

WORKDIR /usr/src/app
COPY package*.json tsconfig*.json ./
COPY ./src ./src

RUN npm ci
#COPY . .
RUN npm run build

# Clean build
RUN npm ci --production
RUN npm cache clean --force

EXPOSE 3000
RUN echo "Building with Endpoint ${MW_ENDPOINT} and Port ${MW_PORT}"

USER node
# Use pm2 for SIGINT handling in docker
CMD [ "node", "./dist/index.js"]
