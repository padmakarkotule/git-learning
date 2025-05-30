Got it — you're using **Jenkins polling** (every 5 minutes) to check for new commits because webhooks aren't available in your private environment.

In this case, **you need to track the last processed (or deployed) commit yourself**, so Jenkins knows where to start the next diff. Git doesn't do this automatically for you during polling.

---

## ✅ Goal:

Track and compare changes since the **last successful poll/deploy**.

---

## ✅ Solution Overview:

1. **Store the last processed commit SHA** somewhere (a file, Git tag, or Jenkins file).
2. On each poll:

   * Get current latest commit (HEAD)
   * Compare it to the stored last commit
   * Detect changes
   * If something changed → deploy, then update the stored SHA

---

## ✅ Step-by-Step Example (Using a File)

### 🔹 1. Script: `deploy-changed.sh`

```bash
#!/bin/bash

# File to store last processed commit
LAST_COMMIT_FILE=".last_processed_commit"

# Get current latest commit SHA
current_commit=$(git rev-parse HEAD)

# Read last processed commit (or default to HEAD~1)
if [ -f "$LAST_COMMIT_FILE" ]; then
  last_commit=$(cat "$LAST_COMMIT_FILE")
else
  last_commit=$(git rev-parse HEAD~1)
fi

echo "Checking for changes between:"
echo "Last commit: $last_commit"
echo "Current commit: $current_commit"

# Get changed top-level folders
changed_folders=$(git diff --name-only "$last_commit" "$current_commit" | cut -d '/' -f1 | sort -u)

if [ -z "$changed_folders" ]; then
  echo "No changes detected."
else
  echo "Changed folders:"
  echo "$changed_folders"

  # Deploy each changed folder
  for folder in $changed_folders; do
    if [[ -d "$folder" ]]; then
      echo "Deploying $folder..."
      cd "$folder"
      if [[ -x ./deploy.sh ]]; then
        ./deploy.sh
      else
        echo "No executable deploy.sh in $folder"
      fi
      cd - > /dev/null
    fi
  done

  # Update last processed commit
  echo "$current_commit" > "$LAST_COMMIT_FILE"
  echo "Updated last commit to: $current_commit"
fi
```

---

### 🔹 2. Jenkins Job Setup

* Schedule: `H/5 * * * *` (every 5 minutes)
* Steps:

  1. Checkout the repo (`git checkout`)
  2. Run the script: `sh ./deploy-changed.sh`

> Make sure `.last_processed_commit` is committed or stored in a persistent workspace, or even better: write to a known Jenkins artifact folder.

---

### ✅ Alternative: Use Git Tags Instead of a File

If you prefer Git-native tracking:

```bash
last_commit=$(git rev-parse last-deployed 2>/dev/null || git rev-parse HEAD~1)
current_commit=$(git rev-parse HEAD)

# After successful deploy:
git tag -f last-deployed "$current_commit"
git push --tags
```

You’ll need to push the tag if you want it shared across environments.

---

## 🧠 Summary

| You Want To Know\...                    | You Should Do                                  |
| --------------------------------------- | ---------------------------------------------- |
| What commits happened since last deploy | Track the SHA from the last run (file/tag/env) |
| How many commits                        | `git rev-list <last>..<current> --count`       |
| What changed                            | `git diff --name-only <last> <current>`        |

---

Would you like me to package this into a complete Jenkins pipeline (`Jenkinsfile`) for you?
