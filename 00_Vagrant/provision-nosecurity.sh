echo PROVISIONIERE NO-SECURITY --------------------------------------------------------------

# selinux temporär deaktivieren
setenforce 0

# disable selinux
if ! grep -qn "SELINUX=disabled" /etc/selinux/config ; then
  cat > /etc/selinux/config << EOF
SELINUX=disabled
SELINUXTYPE=minimum
EOF
else
  echo selinux bereits deaktiviert
fi

 # disable firewalld
if systemctl | grep -q firewalld ; then 
  systemctl stop firewalld
  systemctl disable firewalld
else
  echo Bereits kein firewalld.
fi

