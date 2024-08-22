FROM node:20-alpine3.20

WORKDIR /home/app

COPY . /home/app

RUN npm install

EXPOSE 3000

CMD ["npm", "run", "start:dev"]