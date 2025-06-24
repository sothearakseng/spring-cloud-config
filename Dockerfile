#FROM ubuntu:latest
#LABEL authors="User"
#
#ENTRYPOINT ["top", "-b"]

# Build Stage: Use Maven with JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

# Copy all project files to the container
COPY . /app

# Build the project using Maven (system Maven)
RUN mvn clean package -DskipTests

# Run Stage: Use JDK 21 slim image to run the jar
FROM eclipse-temurin:21-jre

# Copy the built jar from the build stage
COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

