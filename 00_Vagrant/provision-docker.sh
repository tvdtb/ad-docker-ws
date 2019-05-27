
echo PROVISIONIERE DOCKER -------------------------------------------------------------------------

#yum --showduplicates list docker-ce
DOCKER_VERSION=18.09.6
DOCKERCOMPOSE_VERSION=1.24.0
DOCKERCOMPOSE_PATH=/usr/local/bin/docker-compose
DOCKERDISTRIBUTION_VERSION=2.6.2



# https://docs.docker.com/install/linux/docker-ce/centos/
PACKAGES="yum-utils device-mapper-persistent-data lvm2"
if ! rpm -q ${PACKAGES} > /dev/null ; then 
  yum install -y ${PACKAGES}
fi
  
if ! grep -nrq docker.com /etc/yum.repos.d ; then
  yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
else
  echo Docker Repository schon hinzugefuegt
fi
  
if ! rpm -q docker-ce | grep -q ${DOCKER_VERSION} ; then
  if rpm -q docker-ce ; then
    # wrong version
    yum remove -y docker-ce docker-ce-cli containerd.io
  fi
  yum install -y docker-ce-${DOCKER_VERSION} docker-ce-cli-${DOCKER_VERSION} containerd.io
else
  echo Docker ${DOCKER_VERSION} bereits installiert
fi


if ! ${DOCKERCOMPOSE_PATH} -v | grep -q ${DOCKERCOMPOSE_VERSION} ; then
  # https://docs.docker.com/compose/install/
  curl -L "https://github.com/docker/compose/releases/download/${DOCKERCOMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o ${DOCKERCOMPOSE_PATH}
  chmod +x ${DOCKERCOMPOSE_PATH}
else
  echo Docker Compose ${DOCKERCOMPOSE_VERSION} bereits installiert
fi


if ! rpm -q docker-distribution > /dev/null ; then
  yum install -y docker-distribution-${DOCKERDISTRIBUTION_VERSION}
fi

if [ ! -f /etc/docker/daemon.json ] ; then
  mkdir -p /etc/docker
  echo "{}" > /etc/docker/daemon.json
fi

if ! grep -qn "localhost:50000" /etc/docker/daemon.json ; then
  cat <<< $(/usr/local/bin/jq '. + { "insecure-registries": ["localhost:5000"] }' /etc/docker/daemon.json)   > /etc/docker/daemon.json
fi
