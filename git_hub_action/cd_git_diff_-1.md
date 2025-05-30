Perfect — if you want a **tool-agnostic, generic shell script** that works across **Jenkins, GitHub Actions, Azure DevOps**, etc., here's what you need:

---

## ✅ Generic Shell Script to Detect Changed Top-Level Folders

```bash
#!/bin/bash

# Get latest two commits (customize if needed)
commit1=$(git rev-parse HEAD~1)
commit2=$(git rev-parse HEAD)

# Detect changed top-level folders (like micro_service1, etc.)
changed_folders=$(git diff --name-only "$commit1" "$commit2" | cut -d '/' -f1 | sort -u)

# Optional: filter only folders that match your naming convention
# changed_folders=$(echo "$changed_folders" | grep '^micro_service')

echo "Changed folders:"
echo "$changed_folders"

# Example: Loop through and deploy each folder
for folder in $changed_folders; do
  if [ -d "$folder" ]; then
    echo "Deploying $folder..."
    cd "$folder"
    if [ -x ./deploy.sh ]; then
      ./deploy.sh
    else
      echo "No deploy.sh found or not executable in $folder"
    fi
    cd - > /dev/null
  else
    echo "Folder $folder does not exist"
  fi
done
```

---

### ✅ How to Use This:

* Save this as `deploy-changed.sh`
* Make it executable: `chmod +x deploy-changed.sh`
* Call it from Jenkins, GitHub Actions, Azure DevOps, or any CI runner

---

### 🔧 Customize Commit Range

If you’re in a CI/CD environment, you often know the **previous commit** and **current commit**, so you can pass them in:

```bash
./deploy-changed.sh <old_commit_sha> <new_commit_sha>
```

Update the script like this:

```bash
commit1=${1:-$(git rev-parse HEAD~1)}
commit2=${2:-$(git rev-parse HEAD)}
```

So it works both interactively and in pipelines.

---

### 🌍 Compatible With:

| CI Tool            | How to Use the Script                       |
| ------------------ | ------------------------------------------- |
| **Jenkins**        | Run via `sh ./deploy-changed.sh` in a stage |
| **GitHub Actions** | Add as step with `run: ./deploy-changed.sh` |
| **Azure DevOps**   | Use in a Bash task                          |
| **GitLab CI**      | Call in a `script:` section of your job     |

---

Would you like me to generate template snippets for Jenkinsfile or Azure YAML too?

##### you mean I don't need to worry of how many commits 
Great follow-up — here's the clear answer:

---

### ❓ **Do You Need to Worry About How Many Commits Were Pushed?**

✅ **YES** — but **only if you're trying to detect changes over multiple commits** (e.g., in a push with 2+ commits), and you want to **know what changed since the last deploy** or from a known point (e.g., last successful build).

---

### ✅ Summary of Options:

#### 🟢 Option 1: **Compare Last Two Commits (Simple)**

```bash
commit1=$(git rev-parse HEAD~1)
commit2=$(git rev-parse HEAD)
```

* Works fine **if only one commit was pushed**
* ⚠️ **Won’t catch all changes** in a batch push or merge of multiple commits

---

#### 🟢 Option 2: **Compare from Last Known Commit (Better for CI/CD)**

In real CI/CD tools, you should compare:

```bash
git diff --name-only <last_successful_commit> <current_commit>
```

* **`last_successful_commit`** can come from:

  * A file (e.g., `last_commit.txt`)
  * A Git tag (e.g., `last-deployed`)
  * An environment variable (in Jenkins or GitHub Actions)

> This gives you a **reliable diff range**, no matter how many commits happened.

---

### ✅ Generic Script with Flexible Commit Range

```bash
#!/bin/bash

# Accept commit range as parameters (optional)
commit1=${1:-$(git rev-parse HEAD~1)}
commit2=${2:-$(git rev-parse HEAD)}

echo "Comparing changes from $commit1 to $commit2"

changed_folders=$(git diff --name-only "$commit1" "$commit2" | cut -d '/' -f1 | sort -u)

for folder in $changed_folders; do
  if [[ -d "$folder" ]]; then
    echo "Deploying $folder"
    cd "$folder"
    ./deploy.sh
    cd - > /dev/null
  fi
done
```

---

### ✅ Best Practice (CI Pipelines):

| Platform           | How to track last commit                                                         |
| ------------------ | -------------------------------------------------------------------------------- |
| **GitHub Actions** | Use `${{ github.event.before }}` and `${{ github.sha }}`                         |
| **Jenkins**        | Store last successful SHA in a file or use Git plugin env vars                   |
| **Azure DevOps**   | Use `Build.SourceVersion` and previous successful build info                     |
| **Any tool**       | Tag the last deployed commit (e.g., `git tag last-deployed`) and compare with it |

---

### 🧠 Conclusion:

* If you're only checking `HEAD~1` to `HEAD`, it's **okay for simple cases**.
* For **robust deployment automation**, you should track and compare from the **last known deployed commit**.

Let me know what tool you're using most — I can give exact implementation for that.
