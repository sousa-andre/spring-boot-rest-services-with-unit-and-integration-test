FROM maven:3.8.6-openjdk-18 as build
WORKDIR /opt/app
COPY . .
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar .
RUN mvn clean install

FROM openjdk:18-jdk
WORKDIR /opt/app
COPY --from=build /opt/app/target/api.jar .
COPY --from=build /opt/app/opentelemetry-javaagent.jar .
# OTEL_SERVICE_NAME=
# OTEL_EXPORTER_OTLP_ENDPOINT=
# LOKI_ENDPOINT
CMD java -javaagent:./opentelemetry-javaagent.jar -jar api.jar