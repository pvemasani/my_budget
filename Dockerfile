# Use an official Maven image to build the app
FROM maven:3.8.4-openjdk-11 AS build
COPY . /app
WORKDIR /app
RUN mvn clean install

# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/my_budget-*.jar my_budget.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "my_budget.jar"]
