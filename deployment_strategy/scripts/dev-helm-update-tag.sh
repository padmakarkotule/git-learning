#!/bin/bash
set -e

ENV_FILE="$1"
[ -f "$ENV_FILE" ] || { echo "❌ ENV file not found: $ENV_FILE"; exit 1; }

source "$ENV_FILE"

echo "🔁 Updating Helm image tag to $SERVICE_VERSION in tracking repo..."

git clone -b main git@github.com:AdityaBirlaCapitalDigital/dev-env-tracking-devops.git
cd "dev-env-tracking-devops/${DOCKER_IMAGE_NAME}"

echo "$SERVICE_VERSION" > helm_version.txt
git config --global user.email "jenkins.test@example.com"
git config --global user.name "Jenkins Bot"
git add helm_version.txt
git commit -m "Update helm version to $SERVICE_VERSION" || echo "Version already up to date"
git push origin main || echo "Push failed or already up to date"
