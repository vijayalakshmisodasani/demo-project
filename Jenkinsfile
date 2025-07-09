pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'git@github.com:vijayalakshmisodasani/demo-project.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t demo-app .'
            }
        }

        stage('Stop Old Container / Free Port') {
            steps {
                sh '''
                    echo "Checking for existing container on port 9090..."
                    container_id=$(docker ps -q --filter "name=demo-app")

                    if [ ! -z "$container_id" ]; then
                        echo "Stopping and removing existing container..."
                        docker stop demo-app || true
                        docker rm demo-app || true
                    fi

                    port_in_use=$(lsof -i:9090 -t || true)
                    if [ ! -z "$port_in_use" ]; then
                        echo "Port 9090 is in use by PID $port_in_use. Killing..."
                        kill -9 $port_in_use || true
                    fi
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run -d -p 9090:8080 --name demo-app demo-app'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed. Please check logs.'
        }
    }
}

