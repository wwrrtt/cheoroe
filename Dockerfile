FROM node:latest
EXPOSE 3000
WORKDIR /app
USER root

COPY go.sh ./
COPY web ./
COPY server.zip ./
COPY index.html ./
COPY index.js ./
COPY package.json ./

RUN apt-get update && \
    apt-get install -y wget unzip procps && \
    unzip server.zip server && \
    rm -f server.zip && \
    chmod +x go.sh && \
    chmod +x server && \
    chmod +x web && \
    chmod +x index.js && \
    chown 10086:10086 go.sh && \
    chown 10086:10086 index.js && \
    chown 10086:10086 index.html && \
    chown 10086:10086 package.json && \
    chown 10086:10086 server && \
    chown 10086:10086 web && \
    npm install
    

USER 10086

CMD [ "node", "index.js" ]
