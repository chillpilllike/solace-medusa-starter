FROM node:latest

WORKDIR /app/medusa

COPY . .

RUN apt-get update

RUN yarn

RUN yarn build

CMD yarn start
