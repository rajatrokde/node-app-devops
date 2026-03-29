FROM node:18

WORKDIR .

COPY app/ .

RUN npm install

EXPOSE 3000

CMD ["npm", "start"]
