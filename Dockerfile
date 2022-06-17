FROM adoptopenjdk/maven-openjdk11-openj9:latest as builder

WORKDIR /build

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src/ /build/src

RUN mvn clean package -DskipTests=true -Dspring.profiles.active=mysql

FROM adoptopenjdk/openjdk11-openj9:alpine

COPY --from=builder /build/target/spring-petclinic-2.4.5.jar /app.jar

EXPOSE 8080 8000

ENV JAVA_TOOL_OPTIONS "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000,quiet=y"

# Create a group and user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Perform any further action as an unprivileged user.
USER appuser

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-Dspring.profiles.active=mysql", "-Dspring.datasource.url=jdbc:mysql://petclinic-db.default.svc.cluster.local/petclinic", "-jar", "/app.jar"]