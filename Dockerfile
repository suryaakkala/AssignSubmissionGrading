# Use a Maven image to build the project
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use a lightweight Java image to run the app
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copy the WAR file from the build stage
COPY --from=build /app/target/OnlineAssignmentSDP-0.0.1-SNAPSHOT.war app.war

# Expose the application port
EXPOSE 8080

# Command to run the WAR file
CMD ["java", "-jar", "app.war"]
