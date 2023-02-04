pipeline {
    agent any


    environment {
        repository = "sousandre/spring-api"
    }

    stages {
        stage ("Show vars") {
            steps {
                sh 'echo $dockerhub_USR'
                sh 'echo $dockerhub_PSW'
            }
        }
        stage("Checkout") {
            steps {
                checkout scm
            }
        }

        stage('Build image') {
            steps {
                sh "docker build . -t sousandre/spring-api:$BUILD_NUMBER"
            }
        }

        stage('Push image') {
            steps {
                sh 'echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin'
                sh "docker push sousandre/spring-api:$BUILD_NUMBER"
            }
        }
    }
}
