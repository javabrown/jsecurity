FROM openjdk:8-alpine
VOLUME /tmp
ADD target/search*.jar app.jar
ENTRYPOINT exec java -jar /app.jar