
echo PROVISIONIERE SAMBA --------------------------------------------------------------------------

if ! rpm -q samba > /dev/null ; then
  yum install -y samba*
else
  echo SAMBA bereits installiert
fi
  
if ! grep -q "\[projects\]" /etc/samba/smb.conf ; then
  cat > /etc/samba/smb.conf << EOF
[global]
        workgroup = SAMBA
        security = user

        passdb backend = tdbsam

        printing = cups
        printcap name = cups
        load printers = yes
        cups options = raw

[root]
        comment = / directory
        path = /
        valid users = root
        force user = root
        browseable = yes
        read only = No
        inherit acls = Yes


[projects]
        comment = /opt/projects directory
        path = /opt/projects
        valid users = user
        force user = user
        browseable = yes
        read only = No
        inherit acls = Yes

EOF

  smbpasswd -a user << EOF
user
user
EOF

  smbpasswd -a root << EOF
root
root
EOF

systemctl start smb
systemctl start nmb
systemctl enable smb
systemctl enable nmb

else
  echo SAMBA bereits konfiguriert
fi


