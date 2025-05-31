Absolutely! Here’s how to send **email notifications** in a GitHub Actions workflow, similar to how you’d send a message in the Jenkins `post` block.

### **https://github.com/dawidd6/action-send-mail**
---

## ✅ Email Notifications in GitHub Actions

There are **two main ways** to send email in GitHub Actions:

---

### 🔹 Option 1: Using [**`dawidd6/action-send-mail`**](https://github.com/dawidd6/action-send-mail)

> This action uses SMTP and supports Gmail, Outlook, custom SMTP, etc.

### ✅ Step-by-Step Setup

#### 🔐 First, Add Secrets:

Go to your GitHub repo → Settings → Secrets → Actions, and add:

| Secret Name      | Description                        |
| ---------------- | ---------------------------------- |
| `EMAIL_USERNAME` | Your SMTP username (e.g. email)    |
| `EMAIL_PASSWORD` | Your SMTP password or app password |

---

### 📄 Add to GitHub Actions Workflow

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
    subject: ✅ Deployment Succeeded: ${{ github.repository }}
    to: team@example.com
    from: ${{ secrets.EMAIL_USERNAME }}
    body: |
      Hello team,

      Deployment for environment '${{ matrix.environment }}' succeeded.
      Commit: ${{ github.sha }}

      ✅ Deployment completed successfully.

      Regards,
      GitHub Actions
```

#### 🔁 On Failure:

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
    from: ${{ secrets.EMAIL_USERNAME }}
    body: |
      Hello team,

      Deployment for environment '${{ matrix.environment }}' failed.
      Commit: ${{ github.sha }}

      ❌ Please investigate.

      Regards,
      GitHub Actions
```

---

## ✅ Works With:

| Provider     | Notes                                                                                 |
| ------------ | ------------------------------------------------------------------------------------- |
| Gmail        | Use [App Passwords](https://support.google.com/accounts/answer/185833) (2FA required) |
| Outlook      | SMTP is supported                                                                     |
| Company SMTP | Use custom SMTP server and port                                                       |

---

## 🛡️ Important Security Tip

Always use **GitHub Secrets** for sensitive data — never hardcode email or passwords in the YAML file.

---

## ✅ Summary

| Feature            | Supported                |
| ------------------ | ------------------------ |
| ✅ Email on success | Yes                      |
| ✅ Email on failure | Yes                      |
| ✅ Custom content   | Yes (commit, env, etc.)  |
| ✅ Secure           | Yes (via GitHub Secrets) |

---

Would you like an **example that includes Slack + email + dry-run + deploy matrix** all in one workflow?
