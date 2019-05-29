# Build

```
docker build -t tcpdump .
```

# Run 

Mit --net wird das Netzwerk spezifiziert, entweder mit `container:<name>` durch einen Container oder mit dem Namen direkt

```
docker run -it --net=container:test_oracle_1 tcpdump
```