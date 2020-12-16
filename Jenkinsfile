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
            }
        }

        stage('Build Image') {
            steps {
                sh "chmod 777 -R ./"
                sh "ls -l -R"
                sh "cd ./scripts"
                sh "ls -l"
                sh "pwd"
                sh "./docker-build.sh ${registry} ${imageName}"
            }
        }

        stage('Push Image') {
            steps {
                sh "./scripts/docker-push.sh ${registry} ${imageName}"
            }
        }
    }
}
