pipeline {
    environment {
        imageName = 'jenkinsdemo'
        registry = '192.168.20.151:5000/utwoo'
    }

    agent any

    stages {
        stage('Checkout Source') {
            when { branch('develop') }
            steps {
                git url:'http://github.com/utwoo/jenkins-demo.git', branch: 'develop'
                sh 'chmod +x -R ./'
            }
        }

        stage('Build Image') {
            when { branch('develop') }
            steps {
                sh "./scripts/docker-build.sh ${registry} ${imageName}"
            }
        }

        stage('Push Image') {
            when { branch('develop') }
            steps {
                sh "./scripts/docker-push.sh ${registry} ${imageName}"
            }
        }

        stage('Deployment Develop') {
            when { branch('develop') }
            steps {
                sh 'docker-compose up -d'
            }
        }

        stage('Deployment Release') {
            when { tag('release/*') }
            steps {
                sh 'docker-compose -f ./docker-compose.release.yaml up -d'
            }
        }

        stage('Deployment PROD') {
            when { branch('main') }
            steps {
                sh 'docker-compose -f ./docker-compose.product.yaml up -d'
            }
        }
    }
}
