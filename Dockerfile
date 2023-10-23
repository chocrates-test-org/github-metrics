FROM node:20-alpine3.18 AS build-env
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
COPY index.js /app/index.js
WORKDIR /app
RUN npm run build

FROM node:20-alpine3.18
LABEL org.opencontainers.image.source="https://github.com/chocrates-test-org/github-metrics:0.0.1"
COPY --from=build-env /app/dist /app/dist
WORKDIR /app/dist
CMD ["node", "index.js"]
