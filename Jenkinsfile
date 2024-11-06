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
                    def cmd = """
                    docker run -t -d --entrypoint="" devops-lab:latest bash -c "
                        apt-get update &&
                        apt-get install -y maven &&
                        mvn clean install"
                    """
                    echo "Running command: ${cmd}"
                    sh cmd
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
