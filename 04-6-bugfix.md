Perfect — thanks for the clarification. You're essentially describing a **post-release bugfix** flow, but **not intended for immediate production**, more like a patch on a previously released version, e.g., for:

* QA in a staging environment
* Client demo environments
* Temporary environment-specific fixes

This **`bugfix/*` workflow is based on a tagged version from `main`** but doesn’t go back to `main` immediately (unlike `hotfix/*`).

---

# 🐞 Bugfix Branch from Tagged Version (Non-Prod Patch Flow)

---

## 📌 Purpose

| Goal                    | Description                                 |
| ----------------------- | ------------------------------------------- |
| Isolate a fix           | Based on a stable, tagged `main` release    |
| Deploy to staging/QA    | Temporary fixes, not urgent for production  |
| Don't affect production | Doesn’t immediately go back to `main`       |
| Preserve main stability | Leaves `main` clean for controlled releases |

---

## 🔁 Recommended Workflow

```plaintext
main (tag: 1.0.2)
   ↓
bugfix/fix-issue-x  (from tag 1.0.2)
   ↓
  PR → develop or PR → new release (optional)
```

---

## ✅ Step-by-Step Process

### 1️⃣ Identify Tag to Fix From

Let’s say the current release tag is `1.0.2` on `main`.

```bash
git fetch --tags
git checkout tags/1.0.2 -b bugfix/login-error-fix
```

> ✅ You are now working from the **exact snapshot** of `main@1.0.2`.

---

### 2️⃣ Apply and Commit the Bug Fix

```bash
# Fix code
echo "Fixed login error" >> README.md
echo "1.0.2-bugfix1" > version.txt

git add .
git commit -m "Bugfix: login error on 1.0.2"
git push origin bugfix/login-error-fix
```

---

### 3️⃣ Open PR to Target Branch

There are two common options:

#### Option A: PR to `develop`

```plaintext
bugfix/login-error-fix → develop
```

* Fix flows into the next release
* Won’t go live until the next version is released

#### Option B: PR to `release/v1.0.3` (Optional)

If a patch release is being prepared for non-prod use:

```bash
git checkout -b release/v1.0.3 main
# Then merge bugfix via PR
```

* Enables deploying a bugfix-only version to QA or demo envs
* Can be tagged separately (e.g., `1.0.3-qa`)

---

### 4️⃣ Optional: Tag the Bugfix (if deploying)

If you're deploying this version to QA or staging, tag it:

```bash
git tag 1.0.2-bugfix1
git push origin 1.0.2-bugfix1
```

---

## 🔒 Branch Protection and Ownership

| Branch     | PR Required  | Access Level | Notes                            |
| ---------- | ------------ | ------------ | -------------------------------- |
| `bugfix/*` | ✅ Yes        | Devs/QA      | Temporary, delete after merge    |
| `develop`  | ✅ Yes        | Devs/Leads   | Use for future releases          |
| `main`     | 🔒 No direct | Leads only   | Never merge bugfix directly here |

---

## 🧾 CODEOWNERS Addition

```plaintext
/bugfix/* @qa-team @dev-leads
```

---

## ✅ Bugfix Flow Diagram

```plaintext
main (tag: 1.0.2)
   ↑
   └── bugfix/login-error-fix
          ↓
   PR to develop or release/v1.0.3
          ↓
   Optional tag: 1.0.2-bugfix1
```

---

## ✅ Summary

| Step                | Action                                     |
| ------------------- | ------------------------------------------ |
| Base                | Checkout from tag (e.g. `1.0.2`) on `main` |
| Branch              | `bugfix/fix-name`                          |
| Deploy to           | Staging, QA                                |
| Merge to            | `develop` or new `release/*`               |
| Do **not** merge to | `main` directly                            |
| Tag                 | Optional (e.g. `1.0.2-bugfix1`)            |

---

Would you like me to integrate this into your full team workflow guide alongside `feature`, `release`, `hotfix`, and now `bugfix`?
