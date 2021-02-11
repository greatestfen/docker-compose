FROM maven:3.6.1-jdk-8-alpine AS MAVEN_BUILD

# copy the pom and src code to the container 
COPY ./ ./

RUN mvn clean package

# the second stage of our build will use open jdk 8 on alpine 3.9 
FROM openjdk:8-jre-alpine3.9

COPY --from=MAVEN_BUILD /docker-multi-stage-build-demo/target/demo-0.0.1-SNAPSHOT.jar /demo.jar

# set the startup command to execute the jar 
CMD ["java", "-jar", "/demo.jar"]