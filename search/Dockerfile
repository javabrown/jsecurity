FROM openjdk:8-alpine
VOLUME /tmp
ADD target/search*.jar app.jar
ENTRYPOINT exec java -Dspring.data.mongodb=mongodb://mongo/test -Dspring.security.egd=file:/dev/./urandom -jar /app.jar

## PostgreSQL

You must have a locally running instance of Postgres: ```docker run --rm --name postgres -d -p 5432:5432 -e POSTGRES_DB=dev -e POSTGRES_PASSWORD=password postgres:10.4-alpine```

Then, you can connect to the database with the following command: ```docker exec -it [IMAGE] psql -U postgres dev```