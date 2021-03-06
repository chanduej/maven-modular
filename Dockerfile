FROM alpine/git as clone
WORKDIR /app/
RUN git clone https://github.com/chanduej/maven-modular.git

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app/
COPY --from=clone /app/maven-modular/. /app/.
RUN mvn clean install

FROM onatype/nexus3 as publish
WORKDIR /app/
COPY --from=build /app/module1/target/*.jar /app/
COPY --from=build /app/module2/target/*.jar /app/
RUN mvn deploy

FROM openjdk:8-jre-alpine
WORKDIR /app/
COPY --from=publish /app/module1/target/*.jar /app/
COPY --from=publish /app/module2/target/*.jar /app/
EXPOSE 8080
CMD ["java -jar module1-2.0-SNAPSHOT.jar"; "java -jar module2-2.0-SNAPSHOT.jar"]
