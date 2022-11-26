pipeline {
    parameters {
    choice(name: 'VERSION', choices: ['dev', 'latest', 'testing', 'v4.5.3'], description: 'Pick the VERSION')
    }
    agent any 
    stages {
        stage('run_docker') {
            steps {
            sh """
            docker-compose down
            echo "VERSION=${params.VERSION}" > .env
            docker-compose up -d
            """
            }
        }
    }
}
