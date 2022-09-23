FROM gcc:4.9 as build-env
RUN apt-get update; apt-get install -y libgmp3-dev git;
WORKDIR /usr/src/
RUN git clone https://github.com/Swarthmore/poop.git
WORKDIR /usr/src/poop
RUN gcc -lgmp -o poop poop.c

FROM node:16
EXPOSE 3000
ENV NODE_ENV=production
RUN apt-get update; apt-get install -y libgmp3-dev git;
WORKDIR /home/node/app
RUN git clone https://github.com/Swarthmore/poopweb.git
COPY --from=build-env /usr/src/poop/poop /home/node/app/poopweb/bin/poop
WORKDIR /home/node/app/poopweb
RUN npm install
CMD ["node", "./bin/www"]
