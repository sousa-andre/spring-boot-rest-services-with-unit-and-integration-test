pipeline {
    agent any

    environment {
        repository = "sousandre/spring-api"
    }

    stages {
        stage("Build docker image") {
            docker.Build "sousandre/spring-api:$BUILD_NUMBER"
        }
    }
}