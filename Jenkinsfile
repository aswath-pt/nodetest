pipeline {
    agent any
    tools {nodejs "njs-tool"}
     environment {
            CI = 'true'
        }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Code scan Sonarqube') {
        steps {
          script {
       def scannerHome = tool 'sonar-tool';
       withSonarQubeEnv("sonar-server") {
       sh """${tool("sonar-tool")}/bin/sonar-scanner \
       -Dsonar.projectKey=project \
       -Dsonar.sources=. \
       -Dsonar.projectName=project"""
           }
       } 
    }
         }
         
         stage("Quality gate") {
      steps {
        script {
          def qualitygate = waitForQualityGate()
          sleep(10)
          if (qualitygate.status != "OK") {
            waitForQualityGate abortPipeline: true
          }
        }
      }
    }
        
        stage('Test') {
                    steps {
                        sh 'npm test'
                    }
                }
                stage('Deploy Build') {
                            steps {
                                sh 'npm run build'
                            }
                        }

        stage('START') {
                            steps {
                                sh './jenkins/scripts/deliver.sh'
                                input message: 'Finished using the web site? (Click "Proceed" to continue)'
                                sh './jenkins/scripts/kill.sh'
                            }
                        }
        
    }
}
