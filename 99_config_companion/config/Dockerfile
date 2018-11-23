FROM alpine:latest

RUN echo "hello=world" >> /config.txt

VOLUME /config

CMD [ "mv", "/config.txt", "/config" ]