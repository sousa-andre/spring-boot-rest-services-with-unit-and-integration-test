pipeline {
    agent any

    environment {
        repository "sousandre/spring-api"
    }

    stages {
        stage("Build docker image") {
            docker.Build repository + ":$BUILD_NUMBER"
        }
    }
}