pipeline {
    agent any

    environment {
        DOCKER_REPOSITORY = "sousandre/spring-api"
        GIT_SHORT_HASH = GIT_COMMIT.take(7)
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
                sh "docker build -t $DOCKER_REPOSITORY:$GIT_SHORT_HASH ."
                sh "docker tag $DOCKER_REPOSITORY:$GIT_SHORT_HASH $DOCKER_REPOSITORY:latest"
            }
        }

        stage('Push image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USER -p $PASSWORD'
                    sh "docker push $DOCKER_REPOSITORY:$GIT_SHORT_HASH"
                    sh "docker push $DOCKER_REPOSITORY:latest"
                }
            }
        }

        stage("Update ArgoCD application") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh "docker run --rm \
                        -e GITHUB_USERNAME=$USER \
                        -e GITHUB_PASSWORD=$PASSWORD \
                        -e KUSTOMIZE_DIR=application/overlays/production \
                        -e IMAGE_TAG=$GIT_SHORT_HASH \
                        -e IMAGE_NAME=$DOCKER_REPOSITORY \
                        -e REPOSITORY_URL=github.com/sousa-andre/spring-boot-rest-services-with-unit-and-integration-test-config \
                        sousandre/kustomize-image-updater:latest"
                }
            }
        }
    }
}
