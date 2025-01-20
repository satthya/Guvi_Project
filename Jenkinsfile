pipeline {
    agent any
    stages {
        stage('Build and push') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/dev') {
                        git url: "https://github.com/satthya/Guvi_Project.git", branch: "dev"
                        // Build Docker image
                        sh "chmod 777 build.sh"
                        sh "bash build.sh"
                        // Push Docker image to dev repo
                        withCredentials([usernamePassword(credentialsId: "Docker", passwordVariable: "dockerhubpass", usernameVariable: "dockerhubuser")]) {
                            // Sanitize the Docker Hub username to replace '@' and '.' with '_'
                            def sanitizedUsername = env.dockerhubuser.replaceAll('@', '_').replaceAll('\\.', '_')
                            echo "Sanitized Username: ${sanitizedUsername}"
                            sh "docker tag react_application:latest ${sanitizedUsername}/dev:latest"
                            sh "docker login -u ${sanitizedUsername} -p ${env.dockerhubpass}"
                            sh "docker push ${sanitizedUsername}/dev:latest"
                        }
                    } else if (env.GIT_BRANCH == 'origin/main') {
                        git url: "https://github.com/satthya/Guvi_Project.git", branch: "main"
                        // Build Docker image
                        sh "chmod 777 build.sh"
                        sh "bash build.sh"
                        // Push Docker image to prod repo
                        withCredentials([usernamePassword(credentialsId: "Docker", passwordVariable: "dockerhubpass", usernameVariable: "dockerhubuser")]) {
                            // Sanitize the Docker Hub username to replace '@' and '.' with '_'
                            def sanitizedUsername = env.dockerhubuser.replaceAll('@', '_').replaceAll('\\.', '_')
                            echo "Sanitized Username: ${sanitizedUsername}"
                            sh "docker tag react_application:latest ${sanitizedUsername}/prod:latest"
                            sh "docker login -u ${sanitizedUsername} -p ${env.dockerhubpass}"
                            sh "docker push ${sanitizedUsername}/prod:latest"
                        }
                    }
                }
            }
        }
        stage("Deploy") {
            steps {
                echo "This is deploying the code"
                sh "chmod 777 deploy.sh"
                sh "bash deploy.sh"
            }
        }
    }
}
