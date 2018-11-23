FROM alpine:latest 

ADD files.tgz   /tmp/files
ADD test4.txt   /opt/test4.txt
ADD test5.txt   /opt/test5.txt

RUN mv /tmp/files/*   /opt     && \
    rm -rf /tmp/files          && \
    echo "dynamic file" >> /opt/file6.txt


