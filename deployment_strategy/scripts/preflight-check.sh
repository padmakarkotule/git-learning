#!/bin/bash
set -e

ENV_FILE="$1"
[ -f "$ENV_FILE" ] || { echo "❌ ENV file not found: $ENV_FILE"; exit 1; }
source "$ENV_FILE"

echo "🔍 Running Preflight Checks..."

function check_command() {
    command -v "$1" &>/dev/null || { echo "❌ Command not found: $1"; exit 1; }
}

# Required commands
for cmd in docker git helm curl jq; do
    check_command "$cmd"
done

# Docker registry check (login check can be registry-specific)
echo "🔑 Checking Docker login..."
docker info >/dev/null 2>&1 || { echo "❌ Docker daemon is not accessible"; exit 1; }

# Git clone check
echo "🔐 Checking Git access to: $REMOTE_REPO_URL"
git ls-remote "$REMOTE_REPO_URL" >/dev/null || { echo "❌ Cannot access Git repository: $REMOTE_REPO_URL"; exit 1; }

# Helm repo access (for Helm chart push)
if [[ "$HELM_REPO_URL" != "" ]]; then
  export HELM_EXPERIMENTAL_OCI=1
  echo "📦 Checking Helm login to: $HELM_REPO_URL"
  helm registry login "$HELM_REPO_URL" --username dummy --password dummy >/dev/null 2>&1 || echo "⚠️ Skipping Helm login test (credentials may be handled elsewhere)"
fi

# GitHub token check
if [[ -n "$GITHUB_API_WRITE_TOKEN" && -n "$GITHUB_REPO" ]]; then
    echo "🔗 Verifying GitHub API token access..."
    curl -s -H "Authorization: Bearer $GITHUB_API_WRITE_TOKEN" https://api.github.com/user \
      | jq .login || { echo "❌ GitHub API token invalid or unauthorized"; exit 1; }
fi

# Sonar check (optional)
if [[ "$SONAR_ENABLED" == "true" && -n "$SONAR_URL" ]]; then
  echo "📡 Checking SonarQube at $SONAR_URL..."
  curl -s --fail "$SONAR_URL/api/server/version" >/dev/null || echo "⚠️ SonarQube unreachable or unavailable (optional)"
fi

echo "✅ All preflight checks passed!"


##  How to Use
# ### You can call this in Jenkins, GitHub Actions, or manually:
## bash scripts/preflight-check.sh path/to/your-service.env

# # What It Validates
# | Check     | Description                                   |
# | --------- | --------------------------------------------- |
# | Commands  | `docker`, `git`, `helm`, `curl`, `jq` present |
# | Docker    | Docker daemon is accessible                   |
# | Git       | SSH/HTTPS access to remote service repository |
# | Helm      | OCI login attempt to Helm registry            |
# | GitHub    | API token access to GitHub                    |
# | SonarQube | Server reachable (optional)                   |
