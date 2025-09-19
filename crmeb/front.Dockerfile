# 使用官方OpenJDK运行环境作为基础镜像
FROM openjdk:8-jre

# 设置工作目录
WORKDIR /app
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# 复制jar包到容器中
#COPY target/*.jar app.jar
COPY ./new-shop/crmeb/crmeb-front/target/*.jar Crmeb-front.jar

# 暴露应用端口
EXPOSE 20510

# 设置JVM启动参数
#ENV JAVA_OPTS="-Xms512m -Xmx1024m"

# 启动应用
#ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar Crmeb-front.jar"]
ENTRYPOINT ["java","-jar","Crmeb-front.jar"]

