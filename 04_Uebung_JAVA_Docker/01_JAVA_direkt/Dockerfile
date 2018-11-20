#use openjdk
FROM openjdk:8

#copy from workspace to container
COPY src/main/java src/main/java

WORKDIR src/main/java

#compile
RUN javac Demo.java
 
#set Command 
ENTRYPOINT ["java", "Demo"]
