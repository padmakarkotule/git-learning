#!/bin/bash
set -e

ENV_FILE="$1"
GIT_COMMIT="$2"

[ -f "$ENV_FILE" ] || { echo "❌ ENV file not found: $ENV_FILE"; exit 1; }
source "$ENV_FILE"

echo "🏷️ Creating git tag $SERVICE_VERSION for $DOCKER_IMAGE_NAME"

git config --global user.email "jenkins@test.com"
git config --global user.name "Jenkins CI"

git tag -a "$SERVICE_VERSION" -m "Tagging release $SERVICE_VERSION"
git push origin "$SERVICE_VERSION" -f
