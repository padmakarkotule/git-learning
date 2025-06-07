#!/bin/bash
set -e

ENV_FILE="$1"
[ -f "$ENV_FILE" ] || { echo "❌ ENV file not found: $ENV_FILE"; exit 1; }

source "$ENV_FILE"

cd "$HELM_CHART_DIR"

echo "📦 Packaging Helm chart version $SERVICE_VERSION"
helm package . --version "$SERVICE_VERSION" --app-version "$SERVICE_VERSION"

echo "📤 Pushing Helm chart to: $HELM_REPO_URL"
helm push "${DOCKER_IMAGE_NAME}-${SERVICE_VERSION}.tgz" "oci://${HELM_REPO_URL}"

echo "✅ Helm chart pushed: ${DOCKER_IMAGE_NAME}-${SERVICE_VERSION}"
