FROM ubuntu:latest

RUN apt-get update             && \
    apt-get install -y tcpdump && \
	apt-get clean

CMD tcpdump -i eth0 -XX

