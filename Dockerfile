# --- Stage 1: Build WAR bằng Maven + JDK 17 ---
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -q -DskipTests package

# --- Stage 2: Chạy trên Tomcat 10.0.x (Servlet 5.0) ---
FROM tomcat:10.0.27-jdk17-temurin
# Xoá app mẫu của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy WAR của bạn làm ROOT để URL gọn: /
COPY --from=build /app/target/Baitapwebmvc.war /usr/local/tomcat/webapps/ROOT.war

# Giới hạn RAM để hợp Free plan
ENV JAVA_OPTS="-Xms128m -Xmx256m"
EXPOSE 8080
CMD ["catalina.sh", "run"]
