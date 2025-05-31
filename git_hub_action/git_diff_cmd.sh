last_commit=$(cat .last_deployed_commit)
current_commit=$(git rev-parse HEAD)

changed_services=$(git diff --name-only "$last_commit" "$current_commit" \
  | grep '^projects/' \
  | cut -d '/' -f1,2 \
  | sort -u)

echo "Changed services:"
echo "$changed_services"

for folder in $changed_services; do
  echo "Deploying $folder..."
  if [ -x "$folder/deploy.sh" ]; then
    (cd "$folder" && ./deploy.sh)
  else
    echo "No deploy.sh in $folder or not executable"
  fi
done

# Update last deployed commit
echo "$current_commit" > .last_deployed_commit
