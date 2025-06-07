#!/bin/bash
set -e

ENV_FILE="$1"
[ -f "$ENV_FILE" ] || { echo "❌ ENV file not found: $ENV_FILE"; exit 1; }

source "$ENV_FILE"

echo "📦 Cloning source repo..."
git clone -b "$REMOTE_REPO_BRANCH" "$REMOTE_REPO_URL" "$REMOTE_REPO_DIR"

cd "$REMOTE_REPO_DIR"
SERVICE_VERSION=$(tail -n 1 "$SERVICE_VERSION_FILE")
IMAGE_TAG="${SERVICE_VERSION}-${GIT_COMMIT:-$(git rev-parse --short HEAD)}"

echo "🐳 Building Docker image: ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${IMAGE_TAG}"

docker build -t "${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${IMAGE_TAG}" \
  -f "../$DOCKERFILE_PATH" . \
  --build-arg SONAR_ENABLED="$SONAR_ENABLED" \
  --build-arg SONAR_URL="$SONAR_URL" \
  --build-arg SONAR_BRANCH="$SONAR_BRANCH" \
  --build-arg SONAR_TOKEN="$SONAR_TOKEN"

docker push "${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${IMAGE_TAG}"

echo "✅ Image pushed: ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${IMAGE_TAG}"
