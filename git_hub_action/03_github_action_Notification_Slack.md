Perfect! Here's a **complete GitHub Actions workflow** with:

✅ Multi-environment deploy (`uat`, `staging`, `prod`)
✅ Success and failure notifications
✅ Slack integration (via webhook)
✅ Post-build logging and cleanup (like `post { always {} }`)

---

## ✅ Example: Multi-Environment Deploy with Slack Notifications

### 🔧 Prerequisites

1. Store your [Slack Incoming Webhook URL](https://api.slack.com/messaging/webhooks) as a GitHub secret:
   👉 `SLACK_WEBHOOK_URL`

2. Create a Slack message sender script (optional). We’ll use a simple `curl`.

---

### 📄 `.github/workflows/deploy.yml`

```yaml
name: Deploy Microservices

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        environment: [uat, staging, prod]

    env:
      DRY_RUN: false
      HELM_NAMESPACE: ${{ matrix.environment }}

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Setup Helm
        uses: azure/setup-helm@v3

      - name: Run Deploy Script
        id: deploy
        run: |
          echo "Starting deployment for $HELM_NAMESPACE"
          chmod +x ./deploy_changed_services.sh
          ./deploy_changed_services.sh
        env:
          DRY_RUN: false

      - name: ✅ Notify Slack (Success)
        if: ${{ success() }}
        run: |
          curl -X POST -H 'Content-type: application/json' \
            --data '{"text":"✅ *Deployment succeeded* for environment: '${{ matrix.environment }}'"}' \
            $SLACK_WEBHOOK_URL
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}

      - name: ❌ Notify Slack (Failure)
        if: ${{ failure() }}
        run: |
          curl -X POST -H 'Content-type: application/json' \
            --data '{"text":"❌ *Deployment failed* for environment: '${{ matrix.environment }}'"}' \
            $SLACK_WEBHOOK_URL
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}

      - name: 📦 Always Log (like post.always)
        if: always()
        run: |
          echo "Deployment finished for $HELM_NAMESPACE"
```

---

## 🔄 Script Updates (Optional for Multi-env)

If you're using the same `deploy_changed_services.sh` script, just tweak the Helm call to use dynamic namespace:

```bash
helm upgrade --install "$service_dir" ./helm-charts/"$service_dir" \
  --version "$version" \
  -f "$service_dir/values.yaml" \
  --namespace "${HELM_NAMESPACE:-uat}"
```

---

## 📝 Summary

| Feature                                       | Supported?                                 |
| --------------------------------------------- | ------------------------------------------ |
| ✅ Multi-env deploy (`uat`, `staging`, `prod`) | ✅ via `matrix.environment`                 |
| ✅ Slack notifications                         | ✅ with webhook and `curl`                  |
| ✅ Success/failure logic (post block)          | ✅ with `if: success()` and `if: failure()` |
| ✅ Always-run cleanup/logging                  | ✅ with `if: always()`                      |

---

Would you like to also:

* **Manually trigger deployments** via a `workflow_dispatch` input (e.g., select env from UI)?
* Use **environment approval gates** for staging → prod?

I can add those too.
