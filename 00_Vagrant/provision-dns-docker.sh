echo PROVISIONIERE DNS ----------------------------------------------------------------------
HOSTNAME=$1
IP=$2
HOSTIP=$3
DOMAIN=$4
echo HOSTNAME=${HOSTNAME} IP=${IP} HOSTIP=${HOSTIP} DOMAIN=${DOMAIN}

if ! rpm -q dnsmasq > /dev/null ; then
  yum install -y dnsmasq
  systemctl enable dnsmasq
  systemctl start dnsmasq
else
  echo dnsmasq bereits installiert
fi

if ! grep -qn "ad-docker-ws.test" /etc/hosts ; then
cat >> /etc/hosts << EOF
${IP}                 ${HOSTNAME}  ${HOSTNAME}.${DOMAIN}
${HOSTIP}                   host        host.${DOMAIN}
EOF
fi

if [ -d /etc/docker ] ; then 
  if [ ! -f /etc/docker/daemon.json ] ; then
    echo "{}" > /etc/docker/daemon.json
  fi

  if ! grep -qn "${IP}" /etc/docker/daemon.json ; then

    if ! grep -q "${IP}" /etc/docker/daemon.json ; then
      cat <<< $(/usr/local/bin/jq '. + { "dns": ["'${IP}'"] }' /etc/docker/daemon.json)   > /etc/docker/daemon.json
    fi
  fi
fi




