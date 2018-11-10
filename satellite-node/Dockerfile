FROM node:8-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY * /usr/src/app/
COPY data /usr/src/app/data/

RUN npm install

ENTRYPOINT ["node", "/usr/src/app/index.js"]
