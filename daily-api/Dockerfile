FROM maven:3.9.11-eclipse-temurin-21 AS build
WORKDIR /workspace
COPY pom.xml mvnw mvnw.cmd ./
COPY .mvn .mvn
RUN mvn -B -DskipTests dependency:go-offline
COPY src src
COPY checkstyle.xml ./
RUN mvn -B -DskipTests package

FROM eclipse-temurin:21-jre-jammy AS java-runtime

FROM python:3.12-slim-bookworm
COPY --from=java-runtime /opt/java/openjdk /opt/java/openjdk
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
COPY skill-runtime-requirements.txt /tmp/skill-runtime-requirements.txt
RUN pip install --no-cache-dir -r /tmp/skill-runtime-requirements.txt \
    && rm /tmp/skill-runtime-requirements.txt \
    && groupadd --system daily \
    && useradd --system --gid daily --create-home daily
WORKDIR /app
COPY --from=build /workspace/target/daily-api-*.jar app.jar
USER daily
EXPOSE 8080
HEALTHCHECK --interval=15s --timeout=3s --start-period=30s --retries=5 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/actuator/health')" || exit 1
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
