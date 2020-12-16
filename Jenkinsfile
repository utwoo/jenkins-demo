pipeline {
    environment {
        imageName = 'jenkinsdemo'
        registry = '192.168.20.151:5000/utwoo'
    }

    agent any

    stages {
        stage('Checkout Source') {
            when {
                branch('develop')
            }
            steps {
                git url:'http://github.com/utwoo/jenkins-demo.git', branch: 'develop'
            }
        }

        stage('Build Image') {
            when {
                branch('develop')
            }
            steps {
                sh "./scripts/docker-build.sh ${registry} ${imageName}"
            }
        }

        stage('Push Image') {
            when {
                branch('develop')
            }
            steps {
                sh "./scripts/docker-push.sh ${registry} ${imageName}"
            }
        }
    }
}
