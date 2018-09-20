FROM openjdk:10-jre-slim
RUN mkdir -p /app/eureka-service/
COPY build/libs/eureka.jar /app/eureka-service/eureka.jar
RUN apt-get update -y
RUN apt-get install -y vim
RUN apt-get install curl -y
RUN apt-get install -y procps
RUN apt-get install htop -y
RUN apt-get update -y
RUN java -version
VOLUME /tmp
RUN bash -c 'touch /app/eureka-service/eureka.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/eureka-service/eureka.jar"]
EXPOSE 8002
