# GitHub Working with Branches

To start using GitHub branches, here are the basic prerequisites and steps:



### **Step 11: Merging Changes Using `dev`, `release`, and `main` Branches**
First create dev branch and add some file
E.g.

  git checkout -b dev
  cat >>testfile.txt
  cat testfile.txt
  git add .
  git commit -m "added test file"
  git status
  git add .
  git commit -m "added test file"
  git push -u origin dev


Here’s how you can follow this standard branching strategy:

#### **11.1 Feature Branch to `dev`**

1. **Create a feature branch** (if you haven't already):

```bash
git checkout -b feature/awesome-feature
```

2. **Make your changes** (e.g., modify files, add new features).

3. **Stage and commit your changes**:

```bash
git add .
git commit -m "Implemented awesome feature"
```

4. **Push your feature branch to GitHub**:

```bash
git push -u origin feature/awesome-feature
```

5. **Create a Pull Request (PR)** from your `feature/awesome-feature` branch to the `dev` branch on GitHub. Once your PR is reviewed and approved, **merge the feature branch into `dev`**.

#### **11.2 Merge `dev` into `release`**

Once your feature branch is merged into `dev` and the `dev` branch has been tested and is stable, it's time to merge `dev` into the `release` branch.

1. **Switch to the `dev` branch**:

```bash
git checkout dev
```

2. **Make sure `dev` is up to date with the remote**:

```bash
git pull origin dev
```

3. **Create or switch to the `release` branch** (if it doesn’t exist yet, create it):

```bash
git checkout -b release/v1.0
```

4. **Merge `dev` into `release`**:

```bash
git merge dev
```

- Resolve any merge conflicts if they occur.
- After merging, run any additional tests to ensure the release branch is stable.

5. **Push the `release` branch** to GitHub:

```bash
git push origin release/v1.0
```

6. **Create a Pull Request (PR)** from your `release` branch to `main` on GitHub once everything is ready for production.

#### **11.3 Merge `release` into `main`**

Once the code in the `release` branch is stable and ready for production, it's time to merge it into `main`.

1. **Switch to the `main` branch**:

```bash
git checkout main
```

2. **Make sure `main` is up to date with the remote**:

```bash
git pull origin main
```

3. **Merge the `release` branch into `main`**:

```bash
git merge release/v1.0
```

4. **Push `main` to GitHub**:

```bash
git push origin main
```

5. Once the merge is complete, your code is now on the **`main`** branch, ready for deployment or production.

#### **11.4 Clean Up Branches (Optional)**

Once the merge process is completed, you may want to delete the feature, `dev`, and `release` branches locally and remotely (if they are no longer needed). Here's how you do that:

1. **Delete feature branch locally** (after it’s merged):

```bash
git branch -d feature/awesome-feature
```

2. **Delete the `release` branch locally** (if no longer needed):

```bash
git branch -d release/v1.0
```

3. **Delete feature branch remotely**:

```bash
git push origin --delete feature/awesome-feature
```

4. **Delete the `release` branch remotely** (if no longer needed):

```bash
git push origin --delete release/v1.0
```

---

### **Summary of Modified Branch Merging Steps:**

1. **Feature branch** → `dev`:
   - Create a feature branch from `dev`.
   - After development, merge it into `dev`.
   
2. **`dev` branch** → `release`:
   - Merge `dev` into `release` for final testing before production.

3. **`release` branch** → `main`:
   - Merge `release` into `main` for production-ready code.
   
4. **Clean up branches**:
   - Delete the feature and release branches locally and remotely (if no longer needed).

---

This process ensures that you're using a structured workflow to manage your development, testing, and production stages effectively. Each branch has its purpose, and the merges are controlled for stability before deploying to `main`. Let me know if you have any questions or need further clarification!

