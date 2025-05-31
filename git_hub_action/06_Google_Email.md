You're absolutely right — **Google SMTP (Gmail SMTP)** is widely used and reliable for sending emails from GitHub Actions, Jenkins, or scripts.

Below is a **complete guide** to use **Gmail SMTP** in GitHub Actions securely using `dawidd6/action-send-mail`, which is the most straightforward and widely used method for this use case.

---

## ✅ Step-by-Step: Send Email via Gmail SMTP from GitHub Actions

### 🔐 Step 1: Enable "App Passwords" in Your Google Account

1. Visit: [https://myaccount.google.com/security](https://myaccount.google.com/security)
2. Under "Signing in to Google", enable **2-Step Verification** (required for App Passwords).
3. After enabling 2FA, go to **App passwords**.
4. Create a new app password:

   * App: **Mail**
   * Device: **Other** → name it like “GitHub Actions”
5. Copy the generated 16-character password (this is your **SMTP password**).

---

### 🔑 Step 2: Add Secrets to Your GitHub Repo

Go to **Repository → Settings → Secrets → Actions** and add:

| Name             | Value                                     |
| ---------------- | ----------------------------------------- |
| `EMAIL_USERNAME` | Your Gmail address (e.g. `you@gmail.com`) |
| `EMAIL_PASSWORD` | The app password from step 1              |

---

### 📄 Step 3: Add Email Step to GitHub Actions Workflow

```yaml
- name: ✅ Send Email on Success
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
      ✅ Deployment succeeded for environment '${{ matrix.environment }}'
      Commit: ${{ github.sha }}
      Repo: ${{ github.repository }}
```

#### 🔁 Email on Failure

```yaml
- name: ❌ Send Email on Failure
  if: ${{ failure() }}
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: smtp.gmail.com
    server_port: 465
    secure: true
    username: ${{ secrets.EMAIL_USERNAME }}
    password: ${{ secrets.EMAIL_PASSWORD }}
    subject: ❌ Deployment Failed: ${{ github.repository }}
    to: team@example.com
    from: GitHub Actions <${{ secrets.EMAIL_USERNAME }}>
    body: |
      ❌ Deployment failed for '${{ matrix.environment }}'
      Commit: ${{ github.sha }}
      Repo: ${{ github.repository }}
```

---

## ✅ Summary

| What           | How                                                                       |
| -------------- | ------------------------------------------------------------------------- |
| SMTP Server    | `smtp.gmail.com`                                                          |
| Port           | `465` (SSL) or `587` (TLS)                                                |
| Username       | Your Gmail address                                                        |
| Password       | Gmail App Password                                                        |
| GitHub Secrets | Store email + app password securely                                       |
| Action Used    | [`dawidd6/action-send-mail`](https://github.com/dawidd6/action-send-mail) |

---

Would you like:

* A **template workflow** combining Gmail SMTP, Slack, and conditional deploys?
* Or a **Jenkins version** using the same Gmail SMTP?

Happy to build either.
