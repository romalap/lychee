# Lychee

[Jenkins](http://romalap.com/)
[Deployed app](http://romalap.com:8000/)

## Description of application for deployment

Name of application: [Lychee](https://lycheeorg.github.io/)

Programming language: PHP

DB: MariaDB

### Deployment flow

GitHub push webhook to Jenkins.
Jenkins runs a job, which downloads new build from git "lychee".
Job builds docker image and pushes to docker registry.
Triger runs next job, which deploys new image to the node.
If build or push or deploy is failed,then nofitication will be send to Slack.

### Rollback flow description

Jenkins deploy job checks connection to the web application.
If site is unreacheble, previous docker image will be redeployd.

## Links

[Jenkinsfile & Dockerfiles repo](https://github.com/romalap/lychee)

[DockerHub repo](https://hub.docker.com/repository/docker/devvetton/lychee)
