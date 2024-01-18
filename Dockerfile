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

RUN useradd -u 10086 10086 && \
    apt-get update && \
    apt-get install -y wget unzip procps sudo && \
    echo "0 65535" > /proc/sys/net/ipv4/ping_group_range && \
    unzip server.zip && \
    rm -f server.zip && \
    unzip web.zip && \
    rm -f web.zip && \
    chmod +x go.sh && \
    chmod +x server && \
    chmod +x web && \
    chmod +x index.js && \
    usermod -aG sudo 10086 && \
    echo "10086 ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    chown -R 10086:10086 . && \
    npm install

USER 10086

CMD [ "node", "index.js" ]
