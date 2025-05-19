# Step 1: Build the app using Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# Step 2: Use a lighter runtime image
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/email-writer-sb-0.0.1-SNAPSHOT.jar app.jar

# Step 3: Run the app
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
