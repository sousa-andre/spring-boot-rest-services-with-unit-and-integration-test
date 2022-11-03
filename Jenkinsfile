pipeline {
    agent any

    environment {
        repository = "sousandre/spring-api"
    }

    stages {
        stage("Build docker image") {
            script {
                docker.Build "sousandre/spring-api:$BUILD_NUMBER"
            }
        }
    }
}