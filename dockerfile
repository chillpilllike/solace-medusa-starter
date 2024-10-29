FROM node:latest

WORKDIR /app/medusa

COPY . .

RUN apt-get update

RUN yarn

CMD yarn start
