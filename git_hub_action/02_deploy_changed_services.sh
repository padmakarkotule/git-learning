#!/bin/bash
set -e

LOG_FILE="deploy.log"
DRY_RUN=${DRY_RUN:-false}
LAST_COMMIT_FILE=".last_deployed_commit"

log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "🚀 Starting deployment process"

# Step 1: Determine last deployed commit
if [ -f "$LAST_COMMIT_FILE" ]; then
  last_commit=$(cat "$LAST_COMMIT_FILE")
  log "📌 Last deployed commit: $last_commit"
else
  last_commit=$(git rev-list --max-parents=0 HEAD)
  log "🟡 No previous deploy found, using first commit: $last_commit"
fi

# Step 2: Get current commit
current_commit=$(git rev-parse HEAD)
log "🔍 Current commit: $current_commit"

# Step 3: Find changed version.txt files
changed_versions=$(git diff --name-only "$last_commit" "$current_commit" | grep 'version.txt' || true)

if [ -z "$changed_versions" ]; then
  log "✅ No version.txt changes detected. Nothing to deploy."
  exit 0
fi

# Step 4: Deploy services
while read -r file; do
  [ -z "$file" ] && continue
  service_dir=$(dirname "$file")
  version=$(tail -n1 "$file")

  if [ "$DRY_RUN" = true ]; then
    log "🔎 [DRY RUN] Would deploy $service_dir with version $version"
  else
    log "🚀 Deploying $service_dir with version $version"
    helm upgrade --install "$service_dir" ./helm-charts/"$service_dir" \
      --version "$version" \
      -f "$service_dir/values.yaml" \
      --namespace uat
    log "✅ $service_dir deployed successfully"
  fi
done <<< "$changed_versions"

# Step 5: Save latest commit
echo "$current_commit" > "$LAST_COMMIT_FILE"
log "📝 Updated $LAST_COMMIT_FILE with $current_commit"

log "🎉 Deployment process complete"
