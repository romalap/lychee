pipeline {
  environment {
    registry = "devvetton/lychee"
    registryCredential = 'dockerhub'
  }
  parameters {
    choice(name: 'VERSION', choices: ['dev', 'latest', 'testing', 'release', 'v4.5.3'], description: 'Pick the VERSION')
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
          dockerImage = docker.build("devvetton/lychee:${params.VERSION}", "--build-arg TARGET=${params.VERSION} --network=host .")
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
