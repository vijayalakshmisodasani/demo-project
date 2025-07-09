pipeline {
    agent any

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
                sh 'docker build -t demo-app .'
            }
        }

        stage('Stop Old Container / Free Port') {
            steps {
                echo "🧹 Cleaning up existing container and freeing port 9090..."
                sh '''
                    # Check for any existing container named demo-app (even if stopped)
                    container_exists=$(docker ps -a -q -f name=^/demo-app$)

                    if [ ! -z "$container_exists" ]; then
                        echo "Stopping and removing existing demo-app container..."
                        docker rm -f demo-app || true
                    fi

                    # Check if port 9090 is used by any process and kill it
                    port_in_use=$(lsof -i:9090 -t || true)

                    if [ ! -z "$port_in_use" ]; then
                        echo "Killing process using port 9090 (PID: $port_in_use)..."
                        kill -9 $port_in_use || true
                    fi
                '''
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "🚀 Running new container on port 9090..."
                sh 'docker run -d -p 9090:8080 --name demo-app demo-app'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check console output for details.'
        }
    }
}

