pipeline {
    agent any


    environment {
        repository = "sousandre/spring-api"
    }

    stages {
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
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u USER -p PASSWORD'
                    sh "docker push sousandre/spring-api:$BUILD_NUMBER"
                }
            }
        }
    }
}
