FROM maven:3.8.7-openjdk-18-slim AS build

WORKDIR /app

COPY .  .

RUN mvn package -DskipTests

FROM eclipse-temurin:20.0.1_9-jre-alpine

COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /run/demo.jar

ARG USER=devops
ENV HOME /home/$USER
RUN adduser --disabled-password $USER && \
    chown $USER:$USER /run/demo.jar
USER $USER

EXPOSE 8080

CMD java  -jar /run/demo.jar
