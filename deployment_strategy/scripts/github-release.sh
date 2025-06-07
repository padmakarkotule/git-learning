#!/bin/bash
set -e

ENV_FILE="$1"
GIT_COMMIT="$2"
BRANCH="$3"

[ -f "$ENV_FILE" ] || { echo "❌ ENV file not found: $ENV_FILE"; exit 1; }
source "$ENV_FILE"

if [[ "$BRANCH" == "qa" ]]; then
  RELEASE_NAME="rc-${SERVICE_VERSION}"
elif [[ "$BRANCH" == "main" ]]; then
  RELEASE_NAME="release-${SERVICE_VERSION}"
elif [[ "$BRANCH" == "hotfix" ]]; then
  RELEASE_NAME="${SERVICE_VERSION}"
else
  echo "❌ Unsupported branch for release: $BRANCH"
  exit 0
fi

echo "📢 Creating GitHub release $RELEASE_NAME"

curl -L -X POST "https://api.github.com/repos/${GITHUB_REPO}/releases" \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GITHUB_API_WRITE_TOKEN}" \
  -d @- <<EOF
{
  "tag_name": "$RELEASE_NAME",
  "target_commitish": "$GIT_COMMIT",
  "name": "$RELEASE_NAME",
  "body": "Release created by CI for ${DOCKER_IMAGE_NAME} on branch $BRANCH",
  "draft": false,
  "prerelease": false
}
EOF
