FROM node:latest
EXPOSE 3000
WORKDIR /home/choreouser

COPY go.sh /home/choreouser/
COPY web.zip /home/choreouser/
COPY server.zip /home/choreouser/
COPY index.html /home/choreouser/
COPY index.js /home/choreouser/
COPY package.json /home/choreouser/

RUN apt-get update && \
    apt-get install -y wget unzip procps && \
    unzip server.zip server && \
    rm -f server.zip && \
    unzip web.zip server && \
    rm -f web.zip && \
    chmod +x go.sh && \
    chmod +x server && \
    chmod +x web && \
    chmod +x index.js && \
    addgroup --gid 10086 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10086 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser &&\
    npm install

CMD [ "node", "index.js" ]

USER 10086
