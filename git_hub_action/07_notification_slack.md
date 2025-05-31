Great! Here's a **complete GitHub Actions workflow template** that integrates:

✅ **Multi-environment Helm deployment**
✅ **Slack notifications** (on success/failure)
✅ **Gmail SMTP email notifications** (on success/failure)
✅ **Dry-run support**
✅ **Conditional deploys per environment (uat/staging/prod)**

---

## ✅ Full GitHub Actions Workflow: `deploy.yml`

```yaml
name: Deploy Microservices with Notification

on:
  push:
    branches:
      - main
  workflow_dispatch:  # allow manual trigger with env selection
    inputs:
      environment:
        description: "Environment to deploy (uat, staging, prod)"
        required: true
        default: "uat"

jobs:
  deploy:
    runs-on: ubuntu-latest

    env:
      HELM_NAMESPACE: ${{ github.event.inputs.environment || 'uat' }}
      DRY_RUN: false  # or true for testing

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Set up Helm
        uses: azure/setup-helm@v3

      - name: Deploy Services
        id: deploy
        run: |
          echo "Deploying to environment: $HELM_NAMESPACE"
          chmod +x ./deploy_changed_services.sh
          ./deploy_changed_services.sh
        env:
          HELM_NAMESPACE: ${{ env.HELM_NAMESPACE }}
          DRY_RUN: ${{ env.DRY_RUN }}

      # ✅ Slack on success
      - name: ✅ Notify Slack - Success
        if: ${{ success() }}
        run: |
          curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"✅ Deployment *succeeded* for *${{ env.HELM_NAMESPACE }}*.\nRepo: ${{ github.repository }}\nCommit: ${{ github.sha }}\"}" \
            $SLACK_WEBHOOK_URL
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}

      # ❌ Slack on failure
      - name: ❌ Notify Slack - Failure
        if: ${{ failure() }}
        run: |
          curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"❌ Deployment *failed* for *${{ env.HELM_NAMESPACE }}*.\nRepo: ${{ github.repository }}\nCommit: ${{ github.sha }}\"}" \
            $SLACK_WEBHOOK_URL
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}

      # ✅ Email on success
      - name: ✅ Send Email - Success
        if: ${{ success() }}
        uses: dawidd6/action-send-mail@v3
        with:
          server_address: smtp.gmail.com
          server_port: 465
          secure: true
          username: ${{ secrets.EMAIL_USERNAME }}
          password: ${{ secrets.EMAIL_PASSWORD }}
          subject: ✅ Deployment Success for ${{ github.repository }}
          to: team@example.com
          from: GitHub Actions <${{ secrets.EMAIL_USERNAME }}>
          body: |
            ✅ Deployment succeeded for *${{ env.HELM_NAMESPACE }}*
            Repo: ${{ github.repository }}
            Commit: ${{ github.sha }}

      # ❌ Email on failure
      - name: ❌ Send Email - Failure
        if: ${{ failure() }}
        uses: dawidd6/action-send-mail@v3
        with:
          server_address: smtp.gmail.com
          server_port: 465
          secure: true
          username: ${{ secrets.EMAIL_USERNAME }}
          password: ${{ secrets.EMAIL_PASSWORD }}
          subject: ❌ Deployment Failure for ${{ github.repository }}
          to: team@example.com
          from: GitHub Actions <${{ secrets.EMAIL_USERNAME }}>
          body: |
            ❌ Deployment failed for *${{ env.HELM_NAMESPACE }}*
            Repo: ${{ github.repository }}
            Commit: ${{ github.sha }}
```

---

## ✅ Required GitHub Secrets

| Secret Name         | Description                                                     |
| ------------------- | --------------------------------------------------------------- |
| `EMAIL_USERNAME`    | Your Gmail address (e.g. [you@gmail.com](mailto:you@gmail.com)) |
| `EMAIL_PASSWORD`    | App Password from Gmail (not your actual password)              |
| `SLACK_WEBHOOK_URL` | Your Slack webhook URL for the channel                          |

---

## 🧪 Local Testing for Helm Script (`deploy_changed_services.sh`)

Make sure your script supports:

```bash
# use this in the script
--namespace "${HELM_NAMESPACE:-uat}"
```

---

## 💡 Tip: Manual Deploy UI

Thanks to `workflow_dispatch`, you can now **trigger deployments manually** from the GitHub Actions UI and select the environment (`uat`, `staging`, `prod`).

---

Would you like the **Jenkins version** of this same logic next?
