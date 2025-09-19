# 构建阶段
FROM maven:3.8.4-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# 运行阶段
FROM openjdk:8-jre-alpine
LABEL maintainer="your-email@example.com"
WORKDIR /app

# 创建非root用户
RUN addgroup -g 1001 -S crmeb &&\
    adduser -u 1001 -S crmeb -G crmeb

# 从构建阶段复制jar包
COPY --from=builder /app/target/*.jar app.jar

# 设置权限
RUN chown crmeb:crmeb app.jar
USER crmeb

EXPOSE 8080
ENV JAVA_OPTS="-Xms512m -Xmx1024m"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar"]
