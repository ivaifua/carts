node {
  def mvnHome
  stage('Preparation') { // for display purposes
     // Get some code from a GitHub repository
     git url: 'https://github.com/ivaifua/carts.git'
     // Get the Maven tool.
     // ** NOTE: This 'M3' Maven tool must be configured
     // **       in the global configuration.
     mvnHome = tool 'M3'
    sh 'ansible --version'
    sh 'ansible-inventory --list'
  }
  stage('Build') {
     // Run the maven build
     withEnv(["MVN_HOME=$mvnHome"]) {
        sh '"$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore clean package'
        
     }
  }
  stage('Results') {
     junit '**/target/surefire-reports/*.xml'
     archiveArtifacts 'target/*.jar'
  }
}
stage('Deploy approval'){
   input "Deploy to prod?"
}
node {
  stage('Deploy') {
     sh 'ssh jenkins@javamachine sudo systemctl stop carts'
     sh 'scp -oStrictHostKeyChecking=no target/carts.jar jenkins@javamachine:/home/jenkins/carts/'
     sh 'ssh jenkins@javamachine sudo systemctl start carts'
 
  }
}
