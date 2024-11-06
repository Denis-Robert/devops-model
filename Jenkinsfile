pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'devops-lab'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Denis-Robert/devops-model.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Run Maven Build Inside Docker') {
            steps {
                script {
                    docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").inside ("""--entrypoint=''"""){
                        sh 'mvn clean install'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
