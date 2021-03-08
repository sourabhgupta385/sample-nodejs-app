FROM node:12.16.1-alpine

WORKDIR /usr/local/app

COPY package.json /usr/local/app

COPY src/ /usr/local/app/src/

RUN npm install --production

EXPOSE 8080

ENTRYPOINT ["npm", "start"]