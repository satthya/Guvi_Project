pipeline{
    agent any
    stages{
	stage('Build and push') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/dev') {
			git url:"https://github.com/satthya/Guvi_Project.git",branch: "dev"
                        // Build Docker image
                        sh "chmod 777 build.sh"
                        sh "bash build.sh"
                        // Push Docker image to dev repo
                        withCredentials([usernamePassword(credentialsId:"Docker",passwordVariable:"dockerhubpass",usernameVariable:"dockerhubuser")]){
			    // Sanitize the Docker Hub username to replace '@' or '.' with '_'
                            def sanitizedUsername = env.dockerhubuser.replaceAll('[^a-zA-Z0-9_-]', '_')
			    sh "docker tag react_application:latest ${env.dockerhubuser}/dev:latest"
			    sh "docker login -u ${env.dockerhubuser} -p ${env.dockerhubpass}"
			    sh "docker push ${env.dockerhubuser}/dev:latest"}
                    } else if (env.GIT_BRANCH == 'origin/main') {
			git url:"https://github.com/satthya/Guvi_Project.git",branch: "main"
                        // Build Docker image
                        sh "chmod 777 build.sh"
                        sh "bash build.sh"
                        // Push Docker image to prod repo
                        withCredentials([usernamePassword(credentialsId:"Docker",passwordVariable:"dockerhubpass",usernameVariable:"dockerhubuser")]){
                            // Sanitize the Docker Hub username to replace '@' or '.' with '_'
			    def sanitizedUsername = env.dockerhubuser.replaceAll('[^a-zA-Z0-9_-]', '_')
			    sh "docker tag react_application:latest ${env.dockerhubuser}/prod:latest"
			    sh "docker login -u ${env.dockerhubuser} -p ${env.dockerhubpass}"
			    sh "docker push ${env.dockerhubuser}/prod:latest"}
                    }
                }
            }
        }
        stage("Deploy"){
            steps{
                echo "This is deploying the code"
                sh "chmod 777 deploy.sh"
                sh "bash deploy.sh"
            }
        }
    }
}
