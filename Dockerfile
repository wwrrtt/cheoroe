FROM node:latest

WORKDIR /app

EXPOSE 3000

COPY go.sh ./
COPY web.zip ./
COPY server.zip ./
COPY index.html ./
COPY index.js ./
COPY package.json ./

RUN apt-get update &&\
    apt install --only-upgrade linux-libc-dev &&\
    apt-get install -y wget unzip procps sudo iproute2 vim netcat-openbsd &&\
    npm install -g pm2 &&\
    addgroup --gid 10086 choreo &&\
    adduser --disabled-password --no-create-home --uid 10086 --ingroup choreo 10086 &&\
    usermod -aG sudo 10086 &&\
    echo "10086 ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers &&\
    unzip server.zip &&\
    rm -f server.zip &&\
    unzip web.zip &&\
    rm -f web.zip &&\
    chmod +x go.sh &&\
    chmod +x server &&\
    chmod +x index.js &&\
    npm install

CMD [ "node", "index.js" ]

USER 10086
