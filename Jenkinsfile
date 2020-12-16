pipeline {
    environment {
        imageName = 'jenkinsdemo'
        registry = '192.168.20.151:5000/utwoo'
    }

    agent any

    stages {
        stage('Checkout Source') {
            steps {
                git url:'http://github.com/utwoo/jenkins-demo.git', branch: 'develop'
                sh "chmod 777 -R ./"
            }
        }

        stage('Build Image') {
            steps {
                sh "./docker-build.sh ${registry} ${imageName}"
            }
        }

        stage('Push Image') {
            steps {
                sh "./docker-push.sh ${registry} ${imageName}"
            }
        }
    }
}
