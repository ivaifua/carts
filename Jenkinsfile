node {
  def mvnHome
  stage('Preparation') {
     // Get some code from a GitHub repository
     git url: 'https://github.com/ivaifua/carts.git'


  }
  stage('Build') {

     app = docker.build( "silicon-dialect-245108/carts","./")
   //* sh 'docker build -f Dockerfile -t eu.gcr.io/silicon-dialect-245108/carts:3.0.0-$BUILD_NUMBER  . '
   //  sh 'docker build -t carts-db:3.0.0 mongo  '


  }

stage('Deploy approval'){
   input "Deploy to prod?"
}
node {
  stage('Deploy') {
    docker.withRegistry( "https://eu.gcr.io", 'gcr:silicon-dialect-245108' ) {
    app.push("3.0.0-${env.BUILD_NUMBER}")
    app.push("latest")
    }
  //  sh "gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://eu.gcr.io"
    //sh 'docker login -u _json_key -p "$(cat credentials.json)" https://eu.gcr.io'
 //   sh 'docker login -u oauth2accesstoken -p "$(gcloud auth print-access-token)" https://eu.gcr.io'

   //* sh 'cat /var/lib/jenkins/workspace/Terraform/credentials.json | docker login -u _json_key --password-stdin https://eu.gcr.io'
   //* sh " docker -- push eu.gcr.io/silicon-dialect-245108/carts:3.0.0-$BUILD_NUMBER"
    // sh 'docker tag carts:3.0.0 eu.gcr.io/silicon-dialect-245108/carts:3.0.0-$BUILD_NUMBER'
     //sh 'docker push eu.gcr.io/silicon-dialect-245108/carts:3.0.0-$BUILD_NUMBER'


  }
}
}
