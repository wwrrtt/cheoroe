FROM node:latest
EXPOSE 3000
WORKDIR /app
USER root

COPY go.sh ./
COPY web.zip ./
COPY server.zip ./
COPY index.html ./
COPY index.js ./
COPY package.json ./

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget unzip procps
RUN echo "net.ipv4.ping_group_range=0 2147483647" >> /etc/sysctl.conf
RUN unzip server.zip && rm -f server.zip
RUN unzip web.zip && rm -f web.zip
RUN chmod +x go.sh && chmod +x server && chmod +x web && chmod +x index.js
RUN chown 10086:10086 go.sh && chown 10086:10086 index.js && chown 10086:10086 index.html && chown 10086:10086 package.json && chown 10086:10086 server && chown 10086:10086 web
RUN npm install
    

USER 10086

CMD [ "node", "index.js" ]
