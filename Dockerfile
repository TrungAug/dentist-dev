#Build
#FROM maven AS build
#WORKDIR /app
#COPY . .
#RUN mvn clean package -DskipTests
##Run
#FROM tomcat:10.1-jre21
#COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
#EXPOSE 8081
#ENV SPRING_PROFILES_ACTIVE=docker
#CMD [ "catalina.sh","run" ]

# Build stage
FROM maven AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:18-jdk-slim
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

