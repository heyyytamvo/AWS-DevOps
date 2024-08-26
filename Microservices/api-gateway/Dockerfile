FROM node:20-alpine3.20

WORKDIR /home/app

COPY . /home/app


ARG BUILDTIME_ORDER_HOST=default
ARG BUILDTIME_INFO_HOST=default

ENV ORDER_HOST=$BUILDTIME_ORDER_HOST
ENV INFO_HOST=$BUILDTIME_INFO_HOST

RUN npm install
RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "start"]