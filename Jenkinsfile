pipeline {
  environment {
    registry = "devvetton/lychee"
    registryCredential = 'dockerhub'
  }
  parameters {
    choice(name: 'VERSION', choices: ['4.4.0'], description: 'Pick the VERSION')
    }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        checkout scm
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build("devvetton/lychee:${params.VERSION}", "--build-arg LYCHEE_VERSION=${params.VERSION} --network=host .")
        }
      }
    }
    stage('PUSH image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh """
        docker image prune -f
        """
      }
    }
  }
}