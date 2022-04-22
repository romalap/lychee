# Lychee

[Jenkins](http://jenkins.romalap.com/)
[Deployed app](http://lychee.romalap.com/)

## Description of application for deployment

Name of application: [Lychee](https://lycheeorg.github.io/)

Programming language: PHP

DB: MariaDB

### Deployment flow

With new commit GitHub push webhook to Jenkins.
Jenkins runs a job, which downloads new build from git "lychee".
Job builds docker image and pushes to docker registry.
Triger runs next job, which deploy new image to the node.

### Rollback flow description

Jenkins deploy job checks connection to the web application.
If application is unreacheble, previous docker image will be redeployd.

## Links

[Jenkinsfile & Dockerfiles repo](https://github.com/romalap/lychee)

[DockerHub repo](https://hub.docker.com/r/devvetton/lychee)
