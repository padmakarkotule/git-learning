# Place per service in services/service-a/service-a.env
REMOTE_REPO_URL=git@github.com:YourOrg/your-service-repo.git
REMOTE_REPO_BRANCH=main
REMOTE_REPO_DIR=your-service
DOCKER_IMAGE_NAME=your-service
DOCKERFILE_PATH=docker/Dockerfile
SERVICE_VERSION_FILE=version.txt
DOCKER_REGISTRY=yourregistry.azurecr.io
HELM_CHART_DIR=../common-helm-devops/helmcharts/your-service
HELM_REPO_URL=yourregistry.azurecr.io
GITHUB_REPO=YourOrg/your-service-repo
GITHUB_API_WRITE_TOKEN=ghp_exampletoken
SONAR_ENABLED=true
SONAR_URL=http://sonar.example.com
SONAR_TOKEN=example-sonar-token
SONAR_BRANCH=dev
SERVICE_VERSION=1.0.0
