FROM eclipse-temurin:17-jdk AS build
WORKDIR /app

COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

RUN chmod +x ./gradlew

RUN mkdir -p /app/.gradle

# Кэшируем скачанный gradle
RUN chown -R root:root /app/.gradle

RUN ./gradlew --no-daemon --gradle-user-home=/app/.gradle dependencies || true

COPY src src

# Собираем проект с тем же кэшем
RUN ./gradlew --no-daemon --gradle-user-home=/app/.gradle build -x test

# Финальный образ
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
