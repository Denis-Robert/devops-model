# Use Maven as the base image to build the app
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files into the container
COPY . .

# Build the application using Maven
RUN mvn clean install

# Use a smaller base image to run the app
FROM openjdk:11-jre-slim

# Set the working directory for the runtime container
WORKDIR /app

# Copy the built jar file from the build container
COPY --from=build /app/target/model-test.jar /app/app.jar

# Run the application when the container starts
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
CMD ["--help"]
