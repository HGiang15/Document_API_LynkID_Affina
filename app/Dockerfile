FROM node:18-alpine

RUN apk add --no-cache tzdata

LABEL description="Document MMP"

WORKDIR /docs

COPY . .

RUN npm install -g docsify-cli@latest

ENTRYPOINT docsify serve .
