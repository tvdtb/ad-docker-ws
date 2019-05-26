# spring-boot-docker

Beispiel für Spring-Boot mit docker

Anforderungen:
- Linux (bash shell)
- Docker


Der eigentliche Build findet in Docker statt, dazu wird kein Docker im Builder 
benötigt da das maven-Plugin nur den Socket /var/run/docker.sock benötigt.
Es kann aber sinnvoll sin, ein Image mit Docker-CLI zu installieren

```bash
pushd builder
docker build . -t builder:11
popd
```

Der Build wird im Projekt-Verzeichnis mit folgendem Kommando ausgelöst:

```bash
pushd spring-boot-docker
docker run --rm -ti -v ${PWD}:${PWD} -w ${PWD}           \
           -v /tmp/.m2:/root/.m2                         \
           -v /var/run/docker.sock:/var/run/docker.sock  \
           maven:3.5.4-jdk-11                            \
           mvn install -Pdocker -Ddocker.verbose=true
popd
```

Zum Starten wird das erstellte Image mit folgendem Kommando instanziiert:

```bash
docker run --name spring-boot-docker -d -p 8080:8080 spring-boot-docker:0.0.1-SNAPSHOT
```
