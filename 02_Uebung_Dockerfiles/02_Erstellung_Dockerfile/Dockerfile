#An example Dockerfile with ubuntu and git install
FROM ubuntu:latest
MAINTAINER "max.muster@trivadis.com"
COPY somefile.txt /
RUN apt-get install -y git
ENTRYPOINT ["git"]
