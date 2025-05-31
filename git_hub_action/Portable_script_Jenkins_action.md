Perfect! Here's a **complete solution** in **three formats** to automate your Helm-based microservices deployment from a monorepo:

---

## ✅ 1. **Portable Shell Script** (with logging and dry-run)

Save this as `deploy_changed_services.sh`:

```bash
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
```

### 🔹 Usage

* Dry run:

  ```bash
  DRY_RUN=true ./deploy_changed_services.sh
  ```
* Real deploy:

  ```bash
  ./deploy_changed_services.sh
  ```

---

## ✅ 2. **GitHub Actions Workflow**

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy Changed Services

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Helm
        uses: azure/setup-helm@v3

      - name: Deploy Changed Services
        run: |
          chmod +x ./deploy_changed_services.sh
          ./deploy_changed_services.sh
        env:
          DRY_RUN: false  # set to true for dry-run
```

> Make sure `helm` is in your repo or available through charts.

---

## ✅ 3. **Jenkins Declarative Pipeline**

```groovy
pipeline {
    agent any
    environment {
        DRY_RUN = 'false'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://your-repo.git', branch: 'main'
            }
        }

        stage('Setup Helm') {
            steps {
                sh 'curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash'
            }
        }

        stage('Deploy Changed Services') {
            steps {
                sh '''
                  chmod +x ./deploy_changed_services.sh
                  ./deploy_changed_services.sh
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully.'
        }
        failure {
            echo '❌ Deployment failed.'
        }
    }
}
```

> Place `deploy_changed_services.sh` in your repo root or script path.

---

## ✅ Summary

| Format             | What You Get                      |
| ------------------ | --------------------------------- |
| ✅ Bash Script      | Local testing & CI/CD portable    |
| ✅ GitHub Action    | Fully automated on push to `main` |
| ✅ Jenkins Pipeline | Enterprise CI/CD compatible       |

---

Would you like support for:

* Deploying to multiple environments (e.g. UAT, staging)?
* Using Helm `--dry-run` in dry-run mode?
* Notification (e.g. Slack/email) after deploy?

Let me know, and I can enhance this for production-ready use.
