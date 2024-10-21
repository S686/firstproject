# Maven 빌드 단계
FROM --platform=linux/amd64 eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app

# Maven Wrapper 파일 복사
COPY mvnw ./
COPY .mvn/ .mvn/

# 소스 코드 복사
COPY pom.xml .
COPY src ./src

# Maven 빌드 (테스트 생략)
#RUN mvn clean package -DskipTests
#RUN mvn package -Dmaven.test.skip=true
#RUN ./mvnw clean package -DskipTests
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# 실행 단계
FROM --platform=linux/amd64 eclipse-temurin:17-jre-alpine
WORKDIR /app

# 빌드된 JAR 파일 복사
COPY --from=build /app/target/firstproject-0.0.1-SNAPSHOT.jar ./app.jar

# 애플리케이션 실행
EXPOSE 8080
CMD [ "java", "-jar", "app.jar" ]
