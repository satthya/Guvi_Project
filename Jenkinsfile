pipeline {
    agent any

    environment {
        DOCKER_IMAGE_dev = 'satthya04/dev:latest'  // Replace with your Docker image name
	DOCKER_IMAGE_prod = 'satthya04/prod:latest'  // Replace with your Docker image name 
        DOCKER_REGISTRY = 'docker.io'  // Docker Hub registry
    }

    stages {
        stage('Build and Push') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/dev') {
                        // Clone the repository for the 'dev' branch
                        git url: 'https://github.com/satthya/Guvi_Project.git', branch: 'dev'
                        
                        // Build Docker image
                        sh 'chmod 777 build.sh'
                        sh 'bash build.sh'
                        
                        // Push Docker image to dev repo
                        withCredentials([usernamePassword(
                            credentialsId: 'DOCKER',  // Jenkins credentials ID
                            usernameVariable: 'DOCKER_USERNAME',
                            passwordVariable: 'DOCKER_PASSWORD'
                        )]) {
                            sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                            sh "docker push ${DOCKER_IMAGE_dev}"
                        }
                    } else if (env.GIT_BRANCH == 'origin/main') {
                        // Clone the repository for the 'main' branch
                        git url: 'https://github.com/satthya/Guvi_Project.git', branch: 'main'
                        
                        // Build Docker image
                        sh 'chmod 777 build.sh'
                        sh 'bash build.sh'
                        
                        // Push Docker image to prod repo
                        withCredentials([usernamePassword(
                            credentialsId: 'DOCKER',  // Jenkins credentials ID
                            usernameVariable: 'DOCKER_USERNAME',
                            passwordVariable: 'DOCKER_PASSWORD'
                        )]) {
                            sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                            sh "docker push ${DOCKER_IMAGE_prod}"
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "This is deploying the code"
                sh 'chmod 777 deploy.sh'
                sh 'bash deploy.sh'
            }
        }
    }
}
