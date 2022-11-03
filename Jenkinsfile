pipeline {
    agent any

    environment {
        repository = "sousandre/spring-api"
    }

    stages {
        stage("Build docker image") {
            steps {
                docker.Build "sousandre/spring-api:$BUILD_NUMBER"
            }
        }
    }
}