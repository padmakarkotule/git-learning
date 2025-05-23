Certainly! Here's your **Git Command Quick Guide**, reorganized so each command has its **title**, followed by a **1–2 line explanation**, and then the **example**. This format is more concise and scannable—ideal for a cheat sheet.

---

# 🧭 Git Command Cheat Sheet – `padmakarkotule/my-website` (Editing `index.html`)

---

## 📁 **Category 1: Initial Setup & Repository Management**

### 🔹 `git init`

Initialize a new Git repository in the current folder.

```bash
mkdir my-website
cd my-website
git init
```

### 🔹 `git clone`

Clone a remote GitHub repository to your local machine.

```bash
git clone https://github.com/padmakarkotule/my-website.git
cd my-website
```

### 🔹 `git status`

Check the state of your working directory and staging area.

```bash
git status
```

---

## 🌿 **Category 2: Working with Branches**

### 🔹 `git branch`

List all branches or create a new one.

```bash
git branch             # List branches
git branch dev         # Create dev branch
```

### 🔹 `git checkout`

Switch between branches.

```bash
git checkout main
```

### 🔹 `git checkout -b`

Create and switch to a new branch in one step.

```bash
git checkout -b dev
```

### 🔹 `git merge`

Merge changes from one branch into another.

```bash
git checkout main
git merge dev
```

---

## 💾 **Category 3: Staging, Committing, and Pushing Changes with Tags**

### 🔹 `git add`

Stage changes to be included in the next commit.

```bash
echo "<h1>Hello from dev branch</h1>" > index.html
git add index.html
```

### 🔹 `git commit`

Record staged changes with a descriptive message.

```bash
git commit -m "Add headline to index.html in dev"
```

### 🔹 `git push`

Upload your commits to the remote repository.

```bash
git push origin dev
```

### 🔹 `git tag`

Tag a specific commit, usually for versioning.

```bash
git tag v1.0
```

---

## 🔄 **Category 4: Updating Your Local Repository**

### 🔹 `git fetch`

Download remote changes without affecting local files.

```bash
git fetch origin
```

### 🔹 `git pull`

Download and merge changes from a remote branch.

```bash
git pull origin main
```

---

## ⚠️ **Category 5: Handling Conflicts and Temporary Work**

### 🔹 `git stash`

Temporarily save your local changes without committing.

```bash
echo "<footer>Contact us</footer>" >> index.html
git stash
```

### 🔹 `git rebase`

Apply commits from one branch onto another for a cleaner history.

```bash
git checkout dev
git rebase main
```

### 🔹 `git reset`

Unstage files or reset your branch to a previous state.

```bash
git reset HEAD index.html
```

---

## 🌐 **Category 6: Working with Tags and Remotes**

### 🔹 `git remote`

View or manage your remote repository URLs.

```bash
git remote -v
```

### 🔹 `git push --tags`

Push all your tags to the remote repository.

```bash
git push origin --tags
```

---

## 🧹 **Category 7: Cleaning Up and Removing Files**

### 🔹 `git rm`

Remove files from the working directory and stage the removal.

```bash
git rm index.html
git commit -m "Remove index.html from dev"
```

### 🔹 `git clean`

Delete untracked files from your working directory.

```bash
git clean -f
```

---

## 🔁 Bonus: Sync Dev with Main

### 🔹 `git pull`

Update `dev` branch with latest from `main`.

```bash
git checkout dev
git pull origin main
```

---

Would you like me to generate this as a **Markdown document**, **PDF**, or something else for easy reference?
