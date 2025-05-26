Absolutely! Here's the **complete GitHub Workflow Guide** in Markdown format, including:

* `feature/*`, `release/*`, `hotfix/*`, and `bugfix/*` branches
* PR enforcement
* Tagging strategy (`1.0.3-hotfix`, `1.0.3-bugfix`)
* `version.txt` version management

---

````markdown
# 🚀 GitHub Workflow Guide with Hotfix, Bugfix, PRs, Tags, and version.txt

## 📘 Overview

This document outlines the standardized GitHub branching strategy for development, QA, and release management. It includes:

- Branch naming conventions
- Pull Request (PR) flow
- `version.txt` for version tracking
- Git tagging strategy
- Usage of `hotfix/*` and `bugfix/*` for targeted fixes

---

## 🗂️ Branching Structure

| Branch         | Purpose                        | Notes                                   |
|----------------|--------------------------------|-----------------------------------------|
| `main`         | Production-ready code          | Only updated via `release/*` or `hotfix/*` |
| `develop`      | Active development integration | Features merge here                     |
| `feature/*`    | Individual feature branches    | Created off `develop`                   |
| `release/*`    | QA-ready release branches      | Created from `main`                     |
| `hotfix/*`     | Critical production fixes      | Created from `main`                     |
| `bugfix/*`     | QA-only / staging fixes        | Created from `main@tag` (not `main` itself) |

---

## 🔁 Workflow Summary

```plaintext
feature/* → develop → release/* → main
                        ↑         ↓
               bugfix/*    hotfix/* 
````

---

## ✅ Feature Development

### 1. Create Feature Branch

```bash
git checkout develop
git checkout -b feature/login-form
# Code changes...
git push origin feature/login-form
```

### 2. Open PR: `feature/login-form` → `develop`

* Reviewers: dev leads
* CI must pass
* Only merged via PR

---

## 🚀 Release Process

### 1. Update `version.txt` in `develop`

```bash
echo "1.0.3" > version.txt
git add version.txt
git commit -m "Bump version to 1.0.3"
git push origin develop
```

### 2. Create Release Branch

```bash
git checkout main
git checkout -b release/v1.0.3
git push origin release/v1.0.3
```

### 3. Open PR: `develop` → `release/v1.0.3`

### 4. Tag Release

```bash
git tag 1.0.3
git push origin 1.0.3
```

### 5. Open PR: `release/v1.0.3` → `main`

---

## 🔥 Hotfix Process (e.g., `1.0.3-hotfix`)

### 1. Create `hotfix/*` from `main`

```bash
git checkout main
git checkout -b hotfix/fix-crash
```

### 2. Apply Fix and Bump Version

```bash
echo "1.0.3-hotfix" > version.txt
git add .
git commit -m "Hotfix: crash fix"
git push origin hotfix/fix-crash
```

### 3. Open PR: `hotfix/fix-crash` → `main`

### 4. Tag Hotfix

```bash
git tag 1.0.3-hotfix
git push origin 1.0.3-hotfix
```

### 5. Sync with `develop`

Open PR: `main` → `develop`

---

## 🐞 Bugfix Process (e.g., `1.0.3-bugfix`)

### 1. Create `bugfix/*` from `main@tag`

```bash
git fetch --tags
git checkout tags/1.0.3 -b bugfix/qa-login-error
```

### 2. Apply Fix and Update Version

```bash
echo "1.0.3-bugfix" > version.txt
git add .
git commit -m "Bugfix: login issue in 1.0.3"
git push origin bugfix/qa-login-error
```

### 3. Open PR

* Option A: `bugfix/*` → `develop`
* Option B: `bugfix/*` → `release/v1.0.4` (if prepped)

### 4. Tag Bugfix (if deployed)

```bash
git tag 1.0.3-bugfix
git push origin 1.0.3-bugfix
```

---

## 🔒 Branch Protection Rules

| Branch      | PRs Required | Direct Pushes | Tag Enforced | Notes                          |
| ----------- | ------------ | ------------- | ------------ | ------------------------------ |
| `main`      | ✅ Yes        | ❌ No          | ✅ Yes        | Only via `release` or `hotfix` |
| `release/*` | ✅ Yes        | ❌ No          | ⛔ Optional   | QA/staging releases            |
| `develop`   | ✅ Yes        | ❌ No          | ⛔ No         | Integrates all features        |
| `feature/*` | ✅ Yes        | ⛔ Optional    | ⛔ No         | Scoped per developer           |
| `hotfix/*`  | ✅ Yes        | ❌ No          | ✅ Yes        | Critical prod-only patches     |
| `bugfix/*`  | ✅ Yes        | ⛔ Optional    | ✅ (optional) | For QA/staging fixes           |

---

## 🧾 CODEOWNERS

```plaintext
/main @release-managers
/release/* @qa-team @release-managers
/develop @dev-leads
/feature/* @dev-team
/hotfix/* @lead-devs @release-managers
/bugfix/* @qa-team @dev-leads
```

---

## 🧪 Optional CI Tag Validation

```yaml
name: Validate Tag Matches Version
on:
  push:
    tags:
      - '*'

jobs:
  check-version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Compare tag to version.txt
        run: |
          TAG="${GITHUB_REF#refs/tags/}"
          VERSION=$(cat version.txt)
          if [[ "$TAG" != "$VERSION" ]]; then
            echo "❌ Tag '$TAG' does not match version.txt '$VERSION'"
            exit 1
          fi
```

---

## 🧠 Best Practices

* Always use PRs for all merges
* Update `version.txt` before tagging
* Use `feature/*` for development
* Use `release/*` for QA & staging
* Use `hotfix/*` only for production-critical issues
* Use `bugfix/*` for QA/demo-only fixes based on `main@tag`
* Never tag directly on `develop`
* Tag from `release/*`, `hotfix/*`, or `bugfix/*` only

---

## ✅ Final Diagram (Visual Summary)

```plaintext
feature/* → develop ────────→ release/v1.0.3 ───→ main
                              ↑          ↑           ↑
                bugfix/* ←───┘          │       hotfix/* ←──┐
                         version.txt = 1.0.3-bugfix     version.txt = 1.0.3-hotfix
                                   ↓                           ↓
                             Tag: 1.0.3-bugfix            Tag: 1.0.3-hotfix
```

---

```

Would you like a downloadable `.md` file or a PDF version of this document?
```
