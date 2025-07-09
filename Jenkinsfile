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

        stage('Run Docker Container') {
            steps {
                sh '''
                    echo "Cleaning up old container if it exists..."
                    docker rm -f demo-app || true

                    echo "Running new Docker container on port 9090..."
                    docker run -d -p 9090:8080 --name demo-app demo-app
                '''
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

