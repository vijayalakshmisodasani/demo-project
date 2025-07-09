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
                sh 'docker run -d -p 8080:8080 --name demo-app demo-app'
            }
        }
    }
}
