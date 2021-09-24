pipeline {
  agent any
  tools {
    maven 'M2_HOME'
        }
    stages {

      stage ('Checkout SCM'){
        steps {
          checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'git', url: 'https://github.com/rmspavan/jenkins-ansible.git']]])
              }
      }
    	  
	    stage ('Build')  {
	      steps {
                   sh "mvn clean install"
                   sh "mvn package"
              }
         }
    
      stage ('SonarQube Analysis') {
        steps {
              withSonarQubeEnv('sonarq') {
                 sh 'mvn -U clean install sonar:sonar'
				      }
          }
      }
    
	    stage ('Artifact')  {
	      steps {
           rtServer (
             id: "Artifactory",
             url: 'http://192.168.1.245:8082/artifactory',
             username: 'admin',
             password: 'P@ssw0rd',
             bypassProxy: true,
             timeout: 300
                    ) 
           rtUpload (
              serverId: "Artifactory" ,
              spec: '''{
                 "files": [
                    {
                      "pattern": "*.war",
                      "target": "jenkins-libs-snapshot"
                    }
                          ]
                       }''',
                      ) 
                 
              }

      }    
    
	    /* stage ('Upload')  {
	      steps {
                 rtUpload (
                    serverId: "Artifactory" ,
                    spec: '''{
                       "files": [
                         {
                           "pattern": "*.war",
                           "target": "jenkins-libs-snapshot"
                         }
                                ]
                              }''',
                          ) 
              }
      } */
    
      stage ('Publish build info') {
        steps{
            rtPublishBuildInfo(
                serverId: "Artifactory"
            )
          }
      }    
             
    }
}
