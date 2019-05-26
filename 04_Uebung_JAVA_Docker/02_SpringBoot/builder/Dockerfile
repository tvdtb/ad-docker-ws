FROM maven:3.5.4-jdk-11

# install docker
RUN   apt-get update                                                                                            && \
      apt-get install -y apt-transport-https ca-certificates curl software-properties-common                    && \
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -                                   && \
      add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu artful stable"              && \
      apt-get update                                                                                            && \
      apt-get install -y docker-ce                                                                              && \
      apt-get clean

	