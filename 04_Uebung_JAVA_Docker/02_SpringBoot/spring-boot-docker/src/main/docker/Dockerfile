FROM openjdk:11 as builder

ADD maven/spring-boot-docker*.jar /tmp
ADD entrypoint.sh                 /tmp

RUN mkdir -p /opt/spring-boot-docker/lib                   && \
    mkdir -p /opt/spring-boot-docker/bin

RUN cp /tmp/spring*.jar    /opt/spring-boot-docker/lib/spring-boot-docker.jar    && \
    cp /tmp/entrypoint.sh  /opt/spring-boot-docker/bin/entrypoint.sh             && \
    chmod +x /opt/spring-boot-docker/bin/entrypoint.sh

#  FINAL IMAGE --------------------------------------------------------
FROM openjdk:11 

COPY --from=builder   /opt/spring-boot-docker /opt/spring-boot-docker

CMD [ "/opt/spring-boot-docker/bin/entrypoint.sh" ]
