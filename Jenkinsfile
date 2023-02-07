pipeline {
    agent any

    environment {
        repository = "sousandre/spring-api"
        git_short_hash = GIT_COMMIT.take(7)
    }

    stages {
        stage("Checkout") {
            steps {
                checkout scm
            }
        }

        stage("Run tests") {
            agent {
                docker { image 'maven:3.8.6-openjdk-18' }
            }
            steps {
                sh 'mvn test'
            }
        }

        stage('Build image') {
            steps {
                sh "docker build . -t $repository:$git_short_hash"
                sh "docker tag $repository:$git_short_hash $repository:latest"
            }
        }

        stage('Push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USER -p $PASSWORD'
                    sh "docker push $repository:$git_short_hash"
                    sh "docker push $repository:latest"
                }
            }
        }
    }
}
