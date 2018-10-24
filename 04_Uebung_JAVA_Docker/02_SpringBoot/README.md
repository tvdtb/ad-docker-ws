# spring-boot-docker

Beispiel für Spring-Boot mit docker

Anforderungen:
- Linux (bash shell)
- Docker


Da der eigentliche Build in docker stattfindet, wird zuerst ein Builder gebaut, der zusätzlich zu maven und jdk 11 auch Docker enthält.

```bash
pushd builder
docker build . -t builder:11
popd
```

Der Build wird im Projekt-Verzeichnis mit folgendem Kommando ausgelöst:

```bash
pushd spring-boot-docker
docker run --rm -ti                                      \
           -v $(pwd):/opt/spring-boot-docker             \
           -v /root/.m2:/root/.m2                        \
           -w /opt/spring-boot-docker                    \
           --privileged -v /var/run/docker.sock:/var/run/docker.sock    \
           builder:11                                    \
           mvn install -Pdocker -Ddocker.verbose=true
popd
```

Zum Starten wird das erstellte Image mit folgendem Kommando instanziiert:

```bash
docker run --name spring-boot-docker -d -p 8080:8080 spring-boot-docker:0.0.1-SNAPSHOT
```
