

# Docker Server & Config Companion

# bauen der Container
pushd config && docker build -t config .  && popd
pushd server && docker build -t server .  && popd


# Config Container anlegen
#
# Dieser startet (hier simuliert) den Config-Update Prozess und kopiert (einmalig) die Datei config.txt
# in das deklarierte Volume /config
docker run --name config config

# Server Container
#
# Der Server Container bekommt alle Volumes vom (mittlerweile gestoppten) Config-Container
# Damit wird die Datei /config/config.txt sichtbar
docker run --name server --detach --volumes-from config server

docker logs -f server


# Der Config Container kann jetzt automatisch die Datei aktualisieren. Das kann auch mit docker cp simuliert werden
#
docker cp config:/config/config.txt ./config.txt
vi ./config.txt
docker cp ./config.txt config:/config/config.txt


# die Config im Server wurde verändert
docker logs -f server