#!/bin/bash

# Get latest two commits (customize if needed)
commit1=$(git rev-parse HEAD~1)
commit2=$(git rev-parse HEAD)

# Detect changed top-level folders (like micro_service1, etc.)
changed_folders=$(git diff --name-only "$commit1" "$commit2" | cut -d '/' -f1 | sort -u)

# Optional: filter only folders that match your naming convention
# changed_folders=$(echo "$changed_folders" | grep '^micro_service')

echo "Changed folders:"
echo "$changed_folders"

# Example: Loop through and deploy each folder
for folder in $changed_folders; do
  if [ -d "$folder" ]; then
    echo "Deploying $folder..."
    cd "$folder"
    if [ -x ./deploy.sh ]; then
      ./deploy.sh
    else
      echo "No deploy.sh found or not executable in $folder"
    fi
    cd - > /dev/null
  else
    echo "Folder $folder does not exist"
  fi
done
