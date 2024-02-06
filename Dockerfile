FROM openjdk:17
VOLUME /tmp
RUN ./mvn package -DskipTests
EXPOSE 8080
COPY target/g1-0.0.1-SNAPSHOT.jar employees.jar
ENTRYPOINT ["java","-jar","/employees.jar"]
