# GitHub PR Process

   #### **Your merge goal**
   | Your Goal                              | Commands to Run                                    |
   | -------------------------------------- | -------------------------------------------------- |
   | Merge `Feature` → `dev` (promote to prod) | `git checkout dev` → `git merge feature` → `git push` |
   | Merge `dev` → `main` (promote to prod) | `git checkout main` → `git merge dev` → `git push` |
   | # You may use this for first time, if needed.
   | Merge `main` → `dev` (sync updates)    | `git checkout dev` → `git merge main` → `git push` |



=================
Absolutely! Here's a **comprehensive Pull Request (PR) User Guide** that includes:

1. How developers merge changes directly (without PRs).
2. Disadvantages of direct merging.
3. Benefits of using Pull Requests.
4. How PRs work with branch protection rules.
5. A summary table of enforcement behavior.

---

# 🧭 Pull Request (PR) User Guide for Developers

---

## 🔧 1. Traditional Git Workflow: Direct Merging (No PR)

### ✅ Common Steps

In a basic Git workflow without enforced branch protections, developers may merge directly like this:

```bash
# 1. Checkout the main branch
git checkout main

# 2. Merge the feature branch
git merge feature-branch

# 3. Push changes to remote main
git push origin main
```

---

### ❌ Disadvantages of Direct Merging

| Problem                       | Impact                                                    |
| ----------------------------- | --------------------------------------------------------- |
| Lack of review                | Bugs or insecure code may go unnoticed                    |
| No automated testing required | Failing builds or tests may be merged accidentally        |
| History clutter               | Unstructured or unclear commit history                    |
| Hard to track changes         | No formal discussion or rationale recorded for the change |
| Risk of overwriting code      | Without review, conflicts or bad merges are more common   |

---

## ✅ 2. Recommended Workflow: Using Pull Requests (PRs)

Pull Requests (PRs) allow developers to **propose changes**, get **peer feedback**, and **merge safely** into main branches with review and testing.

### 💡 Typical PR Workflow

1. Create a **feature branch**:

   ```bash
   git checkout -b feature/add-login
   ```

2. Make changes, commit:

   ```bash
   git add .
   git commit -m "Add login form and validation"
   ```

3. Push to remote:

   ```bash
   git push origin feature/add-login
   ```

4. Create a PR on GitHub/GitLab/Bitbucket:

   * Target: `main` (or `develop`)
   * Add title, description, and optionally reviewers

5. Wait for:

   * ✅ Code reviews
   * ✅ CI tests to pass

6. Once all checks pass, **merge PR** using:

   * Merge Commit
   * Squash & Merge
   * Rebase & Merge (as per team policy)

---

### ✅ Advantages of Using PRs

| Benefit             | Description                                                   |
| ------------------- | ------------------------------------------------------------- |
| Code Review         | Ensure quality, catch bugs early, knowledge sharing           |
| CI/CD Integration   | Automatically run tests, linting, builds                      |
| History and Context | Document *why* changes were made via descriptions/discussions |
| Audit and Security  | Ensure only reviewed code reaches protected branches          |
| Merge Control       | Enforce who can merge, how it's merged, and when              |

---

## 🔐 3. Branch Protection Rules & Enforcements

Modern Git platforms let teams enforce **branch protection rules** to **prevent direct merges** or bad practices.

### 🚫 Enforced Rules (Example: GitHub)

| Action                        | Allowed? (with protection) | Notes                                    |
| ----------------------------- | -------------------------- | ---------------------------------------- |
| Direct push                   | ❌ Rejected                 | Must go through a PR                     |
| Merge via PR without approval | ❌ Rejected                 | Review required                          |
| Merge via PR with approvals   | ✅ Allowed                  | Must meet all rules                      |
| Force push                    | ❌ Rejected                 | Only if force push is blocked            |
| Admin override                | ⚠️ Optional                | Can be blocked unless allowed explicitly |

---

## 🔐 4. Common Branch Protection Settings (Enable in GitHub Settings)

* ✅ Require PR reviews before merging
* ✅ Require status checks to pass (CI tests, linters)
* ✅ Restrict who can push
* ✅ Prevent force pushes
* ✅ Require signed commits
* ✅ Require linear history (no merge commits)

---

## 📌 Summary

**Do NOT merge directly into `main` or `develop`.**
Instead, always use a Pull Request (PR) so code can be reviewed, tested, and merged cleanly.

This ensures:

* Code quality
* Fewer bugs
* Easier collaboration
* Safer production deployments

---

Would you like this formatted as a PDF, Markdown document, or posted to a team wiki (e.g., Confluence or Notion)?




================

   3. **Push Changes and Tags**:
      ```bash
      git push origin feature/awesome-feature
      git push origin v1.0  # Push the tag to the remote
      `
- **`git log`**: View the history of commits and tags on the current branch.
