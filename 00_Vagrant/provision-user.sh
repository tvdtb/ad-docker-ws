# Handle errors by exiting
set -e

echo PROVISIONIERE USER ---------------------------------------------------------------------------

# User anlegen
if [ ! -d /home/user ] ; then
  echo erzeuge User user
  adduser user
else
  echo User user bereits vorhanden
fi

#user zum sudoer machen
if [ ! -f /etc/sudoers.d/user ] ; then
  echo Berechtige user als sudoer
  cat  > /etc/sudoers.d/user << EOF
#user as sudoer
%user ALL=(ALL) NOPASSWD: ALL
EOF
fi

if ! grep -q "docker aliase" ~user/.bash_profile ; then 
  cat >> ~user/.bash_profile << EOF

#docker aliase BEGIN
alias docker-here='docker run --rm -ti -v \${PWD}:\${PWD} -w \${PWD} '
alias dh='docker run --rm -ti -v \${PWD}:\${PWD} -w \${PWD} '
alias dr='docker run --rm -ti '
alias de='docker exec -ti '
alias dl='docker logs -f --tail 100 '
alias dc='docker-compose'
alias dcl='docker-compose logs -f --tail 100 '
alias dce='docker-compose exec '
#docker aliase END

EOF

fi

# ---------------------------------------------------------------------------------------------------------------------
# SSH konfigurieren

if [ ! -f ~user/.ssh/id_rsa.pub ] ; then 
  mkdir -p ~user
  mv ssh/ ~user/.ssh
  cp ~user/.ssh/id_rsa.pub  ~user/.ssh/authorized_keys
  chown -R user:user ~user/.ssh
  chmod -R 700 ~user/.ssh
fi


