pipeline {
    agent any

    environment {
        CONTAINER_NAME = 'demo-app'
        DOCKER_IMAGE = 'demo-app'
        HOST_PORT = '9090'
        CONTAINER_PORT = '8080'
    }

    stages {
        stage('Clone Repo') {
            steps {
                echo "🔁 Cloning the GitHub repo..."
                git 'git@github.com:vijayalakshmisodasani/demo-project.git'
            }
        }

        stage('Build with Maven') {
            steps {
                echo "⚙️ Building the project with Maven..."
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image..."
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Stop Old Container / Free Port') {
            steps {
                echo "🧹 Cleaning up existing container and freeing port ${HOST_PORT}..."
                sh '''
                    # Stop and remove container if it exists
                    container_exists=$(docker ps -a -q -f name=^/demo-app$)
                    if [ ! -z "$container_exists" ]; then
                        echo "Stopping and removing existing container..."
                        docker rm -f demo-app || true
                    fi

                    # Kill any process using the HOST_PORT
                    port_in_use=$(lsof -i:${HOST_PORT} -t || true)
                    if [ ! -z "$port_in_use" ]; then
                        echo "Port ${HOST_PORT} is used by PID ${port_in_use}. Killing..."
                        kill -9 $port_in_use || true
                    fi
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "🚀 Running new container on port ${HOST_PORT}..."
                sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${CONTAINER_NAME} ${DOCKER_IMAGE}"
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful! App running at http://<your-ip>:${HOST_PORT}"
        }
        failure {
            echo "❌ Pipeline failed. Check the logs for details."
        }
    }
}
