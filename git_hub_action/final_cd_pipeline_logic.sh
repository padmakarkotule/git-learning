#!/bin/bash

set -e  # Exit on error

# 📍 Step 1: Determine the commit range
# Get the last deployed commit from the `last-deployed` tag, or fallback to HEAD~1
last_commit=$(git rev-parse last-deployed 2>/dev/null || git rev-parse HEAD~1)
current_commit=$(git rev-parse HEAD)

echo "Comparing changes from:"
echo "  Last deployed: $last_commit"
echo "  Current:       $current_commit"

# 📍 Step 2: Find changed top-level service folders under `projects/`
changed_services=$(git diff --name-only "$last_commit" "$current_commit" \
  | grep '^projects/' \
  | cut -d '/' -f1,2 \
  | sort -u)

if [ -z "$changed_services" ]; then
  echo "✅ No changed services detected. Nothing to deploy."
  exit 0
fi

echo "📦 Changed services detected:"
echo "$changed_services"

# 📍 Step 3: Loop and deploy each service
for folder in $changed_services; do
  echo "🚀 Deploying $folder..."

  if [ -x "$folder/deploy.sh" ]; then
    (cd "$folder" && ./deploy.sh)
    echo "✅ $folder deployed successfully."
  else
    echo "⚠️  No executable deploy.sh found in $folder — skipping."
  fi
done

# 📍 Step 4: Update the `last-deployed` Git tag
echo "🔖 Tagging current commit as last-deployed..."
git tag -f last-deployed "$current_commit"
git push origin --force --tags

echo "✅ Deployment complete. Updated last-deployed to $current_commit."
