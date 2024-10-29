FROM node:latest

WORKDIR /app/medusa

COPY . .

RUN apt-get update

RUN yarn install

CMD yarn dev
