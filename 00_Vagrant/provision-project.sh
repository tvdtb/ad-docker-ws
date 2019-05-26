echo PROVISIONIERE PROJEKT ------------------------------------------------------------------------

REPOSITORY=https://github.com/tvdtb/ad-docker-ws
PROJECT=ad-docker-ws
PROJECTS=/opt/projects

# Projektverzeichnis anlegen
if [ ! -d ${PROJECTS} ] ; then
  mkdir -p ${PROJECTS}
else
  echo Projektverzeichnis ${PROJECTS} existiert bereits
fi

PACKAGES="acl git"
if ! rpm -q ${PACKAGES} > /dev/null ; then
  yum install -y ${PACKAGES}
fi

if [ ! -d ${PROJECTS}/${PROJECT}/.git ] ; then
  mkdir -p ${PROJECTS}/${PROJECT}   &&  \
  pushd ${PROJECTS}/${PROJECT}      &&  \
  git init                            &&  \
  git remote add origin ${REPOSITORY} &&  \
  git pull origin master
else
  echo Projekt bereits initialisiert
fi


if [ "$(stat -c "%U" ${PROJECTS})" != "user"  ] ;  then
  # Owner ist "user", group ist "user"
  chown -R user:user ${PROJECTS}
  # All Files/Directories will be group "user"
  chmod -R g+s /opt/projects/
  # Setze ACLs
  setfacl -m g:user:rwx -R ${PROJECTS}
  setfacl -m d:g:user:rwx -R ${PROJECTS}
else
  echo Permissions bereits gesetzt
fi

