pipeline {
    agent { label 'mvnslave1' }
	

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
      maven "MAVEN"
    }

	environment {	
		DOCKERHUB_CREDENTIALS=credentials('dockerloginid')
	} 
    

    stages {
        stage('SCM Checkout') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/TejasPatel21/java-docker.git'
            }
		}
        stage('Maven Build') {
            steps {
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
		}
        stage("Docker build"){
            steps {
				sh 'docker version'
                sh 'pwd'
				sh 'docker build -t kubdockerimage .'
				sh 'docker image list'
				sh 'docker tag kubdockerimage patel21/kubdocker:latest'
            }
        }
		stage('Login2DockerHub') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
		stage('Push2DockerHub') {
			steps {
				sh 'docker push patel21/kubdocker:latest'
			}
		}
        stage('Deploy to Kubernetes Cluster using Ansible Playbook') 
        {
            agent{
                label 'ansibleadmin1'
            }
            steps{
                ansiblePlaybook 'ansible.yml'
            }
            
	    }
    }
}
