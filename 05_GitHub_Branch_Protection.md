To enforce **branch protection** and control **which branches can be deleted**, you can configure rules in **GitHub’s repository settings**. Below is a step-by-step guide to ensure:

✅ `main` and `develop` are protected (can't be deleted)
✅ All other branches like `feature/*`, `bugfix/*`, etc. can be deleted after merge (automatically or manually)

---

## 🔐 Step-by-Step: Protect `main` and `develop` Branches

### 🔧 Step 1: Go to Branch Protection Rules

1. Open your GitHub repository (e.g., `workflow-lab`)
2. Go to **Settings** → **Branches**
3. Click **"Add branch protection rule"**

---

### 🔐 Step 2: Protect `main` branch

1. **Branch name pattern:** `main`
2. Enable these options:

   * ✅ Require a pull request before merging
   * ✅ Require approvals (optional)
   * ✅ Require status checks to pass (if CI)
   * ✅ **Prevent branch from being deleted**
3. Click **"Create"**

Repeat the same steps for `develop`.

---

### 🔄 Step 3: Auto-delete Merged Branches (like `feature/*`)

1. Go to **Settings** → **General**
2. Scroll to **"Pull Request"** section
3. Enable:

   > ✅ Automatically delete head branches

This will delete branches like:

* `feature/*`
* `bugfix/*`
* `hotfix/*`
* `release/*`

...**after the pull request is merged**, as long as they’re not protected.

---

## 🧪 Example Behavior

| Branch Name      | Protected | Deleted After Merge? |
| ---------------- | --------- | -------------------- |
| `main`           | ✅ Yes     | ❌ No (Protected)     |
| `develop`        | ✅ Yes     | ❌ No (Protected)     |
| `feature/footer` | ❌ No      | ✅ Yes (Auto-delete)  |
| `bugfix/css`     | ❌ No      | ✅ Yes (Auto-delete)  |

---

## 🧠 Tip:

Developers will get an error if they try to delete `main` or `develop` via GitHub or command line.

---

Would you like a short script or documentation snippet to share with your team explaining this config?
