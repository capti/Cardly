FROM eclipse-temurin:17-jdk as build
WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .
COPY src src

# Предоставляем права на исполнение градл-враппера
RUN chmod +x ./gradlew
RUN ./gradlew build -x test

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"] 