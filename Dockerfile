FROM openjdk:17 AS builder

WORKDIR /

# Copy the Maven wrapper script and the Maven configuration
COPY mvnw .
COPY .mvn .mvn

# Copy the project Object Model (POM) file
COPY pom.xml .

# Fetch all dependencies
RUN ./mvnw dependency:go-offline -B

# Copy the application source code
COPY src src

# Package the application
RUN ./mvnw package -DskipTests

# Final stage: create the runtime image
FROM openjdk:17

WORKDIR /

# Copy the packaged JAR file from the builder stage
COPY --from=builder /app/target/g1-0.0.1-SNAPSHOT.jar employees.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "employees.jar"]
