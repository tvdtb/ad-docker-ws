#Stage 1 - Build Stage
FROM golang:1.8-alpine as build

COPY src /usr/src/app
RUN cd /usr/src/app && \
    go build

#Stage 2 - Run Stage
FROM alpine:latest
WORKDIR /root/
COPY --from=build /usr/src/app/app .
RUN chmod +x app
CMD ["./app"]
EXPOSE 80

