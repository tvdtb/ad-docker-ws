echo PROVISIONIERE DNS ----------------------------------------------------------------------

if ! rpm -q dnsmasq > /dev/null ; then
  yum install -y dnsmasq
  systemctl enable dnsmasq
  systemctl start dnsmasq
else
  echo dnsmasq bereits installiert
fi

if ! grep -qn "ad-docker-ws.test" /etc/hosts ; then
cat >> /etc/hosts << EOF
192.168.88.3          ad-docker-ws  ad-docker-ws.test
192.168.88.1                  host          host.test
EOF
fi

if [ -d /etc/docker ] ; then 
  if [ ! -f /etc/docker/daemon.json ] ; then
    echo "{}" > /etc/docker/daemon.json
  fi

  if ! grep -qn "192.168.88.3" /etc/docker/daemon.json ; then

    if ! grep -q "192.168.88.3" /etc/docker/daemon.json ; then
      cat <<< $(/usr/local/bin/jq '. + { "dns": ["192.168.88.3"] }' /etc/docker/daemon.json)   > /etc/docker/daemon.json
    fi
  fi
fi




