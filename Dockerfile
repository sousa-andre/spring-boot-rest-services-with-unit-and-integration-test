FROM maven:3.8.6-openjdk-18
COPY . /opt/app
WORKDIR /opt/app
RUN mvn package
CMD mvn spring-boot:run