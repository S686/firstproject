# Maven 빌드 단계
FROM maven:3.9.0-eclipse-temurin AS build
WORKDIR /app

# 소스 코드 복사
COPY . .

# Maven 빌드 (테스트 생략)
RUN mvn clean package -DskipTests

# 실행 단계
FROM eclipse-temurin:17-jre
WORKDIR /app

# 빌드된 JAR 파일 복사
COPY --from=build /app/target/firstproject-0.0.1-SNAPSHOT.jar /app.jar

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
