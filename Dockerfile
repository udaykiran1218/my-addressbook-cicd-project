# ---- Build Stage ----
FROM maven:3.8.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# ---- Runtime Stage ----
FROM openjdk:17-oraclelinux8

WORKDIR /app
COPY --from=builder /app/target/addressbook.war app.war

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.war"]
