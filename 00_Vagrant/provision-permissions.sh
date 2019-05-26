echo PROVISIONIERE BERECHTIGUNGEN -----------------------------------------------------------

# Allow user for docker
if grep -q docker: /etc/group ; then
  if ! grep docker: /etc/group | grep -q user ; then
    usermod -G docker -a user
  else
    echo User user darf bereits docker nutzen
  fi
else
  echo Keine Gruppe Docker
fi