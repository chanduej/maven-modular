node {
  echo "Jenkins Job Number ${env.BUILD_NUMBER}"
  echo "Jenkins Node Name ${env.NODE_NAME}"
  echo "Jenkins Home ${env.JENKINS_HOME}"
  echo "Jenkins URL ${env.JENKINS_URL}"
  echo "JOB Name ${env.JOB_NAME}"
  
  stage('Docker Image Build')
  {
    sh 'docker build -t <repo/image name> -f ~/maven-moduler/Dockerfile'
  }
  stage("Docker Container Deploy")
  {
    sh 'docker build -d -p 8080:8080 test --name testcontainer'
  }
  stage('archive (includes: 'pkg/*.gem')')
  {
    publishHTML (target: [
      allowMissing: false,
      alwaysLinkToLastBuild: false,
      keepAll: true,
      reportDir: 'coverage',
      reportFiles: 'index.html',
      reportName: "<report name>"
    ])
  }
}
