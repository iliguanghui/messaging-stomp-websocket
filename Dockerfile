FROM maven:3.9.2-amazoncorretto-17-debian-bullseye AS build
COPY settings.xml /usr/share/maven/conf/
WORKDIR /build
COPY initial/pom.xml ./
RUN mvn dependency:resolve && mvn dependency:resolve-plugins
COPY initial ./
RUN mvn clean package -Dmaven.test.skip=true
FROM registry.cn-hangzhou.aliyuncs.com/lgypro/eclipse-temurin-debug:17
WORKDIR /app
COPY jmx_exporter/ agent/
EXPOSE 8080/tcp
COPY --from=build /build/target/messaging-stomp-websocket-initial-0.0.1-SNAPSHOT.jar ./app.jar
CMD ["sh", "-c", "exec java ${JAVA_OPTS} -jar app.jar"]
