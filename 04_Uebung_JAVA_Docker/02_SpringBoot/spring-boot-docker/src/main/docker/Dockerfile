FROM openjdk:11.0.1-jdk-slim-sid as builder

RUN apt-get update && apt-get install -y binutils && apt clean && \
    jlink --module-path $JAVA_HOME/jmods --verbose \
           --add-modules java.base,java.naming,java.sql,java.desktop,java.management,java.security.jgss,java.instrument \
		   --compress 2 --no-header-files --no-man-pages --strip-debug --vm server \
		   --output /opt/java-minimal  \
	 && \
		   find /opt/java-minimal -follow -name "*.so" | xargs strip -p --strip-unneeded --strip-debug
		   #see https://github.com/docker-library/openjdk/issues/217
			
ADD maven/spring-boot-docker*.jar /tmp
ADD entrypoint.sh                 /tmp

RUN mkdir -p /opt/spring-boot-docker/lib                   && \
    mkdir -p /opt/spring-boot-docker/bin

RUN cp /tmp/spring*.jar    /opt/spring-boot-docker/lib/spring-boot-docker.jar    && \
    cp /tmp/entrypoint.sh  /opt/spring-boot-docker/bin/entrypoint.sh             && \
    chmod +x /opt/spring-boot-docker/bin/entrypoint.sh

	
	
#  FINAL IMAGE --------------------------------------------------------
FROM debian:sid-slim

ENV PATH=$PATH:/opt/java-minimal/bin   \
    JAVA_HOME=/opt/java-minimal
COPY --from=builder   /opt/java-minimal       /opt/java-minimal

COPY --from=builder   /opt/spring-boot-docker /opt/spring-boot-docker

CMD [ "/opt/spring-boot-docker/bin/entrypoint.sh" ]
