FROM openjdk:11
COPY target/demo-project-1.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
