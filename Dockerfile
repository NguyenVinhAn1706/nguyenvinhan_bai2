# Stage 1: Build WAR bằng Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn -B -DskipTests clean package

# Stage 2: Deploy WAR lên Tomcat
FROM tomcat:9.0-jdk17
# Xóa webapps mặc định
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy file WAR đã build vào ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
