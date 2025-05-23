# Git commands based on the workflow

It’s a great idea to categorize Git commands based on the workflow to make it easier for newcomers to understand how Git works. Here's how you can break it down into **logical categories** to help new developers grasp the sequence and purpose of each command.

1. **Category 1: Initial Setup & Repository Management**
2. **Category 2: Working with Branches**
3. **Category 3: Staging, Committing, and Pushing Changes with tags**
4. **Category 4: Updating Your Local Repository**
5. **Category 5: Handling Conflicts and Temporary Work**
6. **Category 6: Working with Tags and Remotes**
7. **Category 7: Cleaning Up and Removing Files**

---

### **Category 1: **Initial Setup & Repository Management**

This category includes commands related to setting up a new repository and cloning an existing one.

| **Command**      | **Purpose**                                                                | **Example**                                                         |
|------------------|----------------------------------------------------------------------------|---------------------------------------------------------------------|
| **`git init`**    | Initialize a new Git repository.                                           | `git init`                                                          |
| **`git clone`**   | Clone an existing repository to your local machine.                        | `git clone https://github.com/user/repository.git`                   |
| **`git status`**  | Check the current status of your working directory (staged, unstaged).     | `git status`                                                        |

#### **Explanation**:
- **`git init`**: Creates a new Git repository in your local directory.
- **`git clone`**: Creates a copy of an existing remote repository on your local machine.
- **`git status`**: Helps you see which changes are staged, unstaged, or untracked in your working directory.

#### **Examples**:
- **`git init`**: Creates a new Git repository in your local directory.
   - Create empty folder in your local directory e.g. mkdir new_github_repo
   - 
- **`git clone`**: Creates a copy of an existing remote repository on your local machine.
- **`git status`**: Helps you see which changes are staged, unstaged, or untracked in your working directory.
---

### **Category 2: Working with Branches**

This category covers commands related to **branching** in Git. Branches are essential for parallel development in Git workflows.

| **Command**             | **Purpose**                                                                 | **Example**                                                           |
|-------------------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------------|
| **`git branch`**         | List existing branches or create a new branch.                              | `git branch` (lists branches), `git branch feature/awesome-feature`   |
| **`git checkout`**       | Switch between branches or revert to a previous commit.                    | `git checkout main`                                                   |
| **`git checkout -b`**    | Create a new branch and switch to it immediately.                           | `git checkout -b feature/awesome-feature`                             |
| **`git merge`**          | Merge changes from another branch into your current branch.                | `git merge feature/awesome-feature`                                    |

#### **Explanation**:
- **`git branch`**: View the branches in your repository or create a new one.
- **`git checkout`**: Switch between branches or reset to a previous commit.
- **`git checkout -b`**: Create and switch to a new branch in one step.
- **`git merge`**: Merge changes from one branch into another.

#### **Examples**:
- **`git branch`**: View the branches in your repository or create a new one.
- **`git checkout`**: Switch between branches or reset to a previous commit.
- **`git checkout -b`**: Create and switch to a new branch in one step.
- **`git merge`**: Merge changes from one branch into another.

---

### **Category 3: Staging, Committing, and Pushing Changes (Including Tags)**

This category helps you track and save changes to your local repository, push them to a remote repository, and optionally tag them for future reference.

| **Command**             | **Purpose**                                                                | **Example**                                                            |
|-------------------------|----------------------------------------------------------------------------|------------------------------------------------------------------------|
| **`git add`**            | Stage changes to be committed.                                             | `git add index.html`                                                   |
| **`git commit`**         | Commit the staged changes with a message describing the change.             | `git commit -m "Added new feature to index.html"`                       |
| **`git push`**           | Push committed changes to a remote repository.                             | `git push origin feature/awesome-feature`                               |
| **`git tag`**            | Tag a specific commit to mark it for reference (e.g., for releases).       | `git tag v1.0`                                                          |
| **`git log`**            | View the commit history of your current branch.                            | `git log`                                                              |

#### **Explanation**:
- **`git add`**: Stage your modified files, telling Git to include them in the next commit.
- **`git commit`**: Record the staged changes in the local repository with a descriptive commit message.
- **`git push`**: Upload your committed changes to the remote repository (e.g., GitHub).
- **`git tag`**: Create a tag for a specific commit. This is often used for marking releases or important milestones in the project history.
- **`git log`**: View the history of commits and tags on the current branch.


#### **Examples**:
- **`git add`**: Stage your modified files, telling Git to include them in the next commit.
- **`git commit`**: Record the staged changes in the local repository with a descriptive commit message.
- **`git push`**: Upload your committed changes to the remote repository (e.g., GitHub).
- **`git tag`**: Create a tag for a specific commit. This is often used for marking releases or important milestones in the project history.
- **`git log`**: View the history of commits and tags on the current branch.
---

### Example Workflow with `git tag`:

1. **Stage and Commit Changes**:
   ```bash
   git add index.html
   git commit -m "Fixed bug in index.html"
   ```

2. **Create a Tag** (e.g., marking a release):
   ```bash
   git tag v1.0
   ```

3. **Push Changes and Tags**:
   ```bash
   git push origin feature/awesome-feature
   git push origin v1.0  # Push the tag to the remote
   ```

By placing `git tag` in Category 3, we reflect the fact that it's part of your typical Git workflow after committing and before pushing changes (or tagging a specific commit to mark a release). It follows logically after pushing changes, as you may want to create a tag just before or after pushing commits to the remote.

Let me know if you need more clarification or examples!

---

### **Category 4: Updating Your Local Repository**

This category involves pulling changes from remote repositories to ensure your local repository stays up to date.

| **Command**             | **Purpose**                                                                | **Example**                                                         |
|-------------------------|----------------------------------------------------------------------------|---------------------------------------------------------------------|
| **`git fetch`**          | Fetch the latest changes from the remote without merging them.             | `git fetch origin`                                                  |
| **`git pull`**           | Fetch and merge the latest changes from the remote repository into your current branch. | `git pull origin main`                                               |

#### **Explanation**:
- **`git fetch`**: Retrieve the latest changes from the remote without modifying your working directory.
- **`git pull`**: Fetch the latest changes and merge them into your current branch.

#### **Examples**:
- **`git fetch`**: Retrieve the latest changes from the remote without modifying your working directory.
- **`git pull`**: Fetch the latest changes and merge them into your current branch.
 
- `Example - git fetch`:
   1. Open github.com from web site, go to your repository and change the README.md file, commit and update the change.
   2. On local use command `git fetch`
   3. Check the **status of your local branch compared to the remote**
      You can also use git status to get a summary of how your local branch relates to the remote:
      git command - `git status`
      
      E.g. 
      $ git status
      On branch main
      Your branch is behind 'origin/main' by 1 commit, and can be fast-forwarded.
      ----------------    --------------- -- --------
      (use "git pull" to update your local branch)
      -------------------------------------------

      nothing to commit, working tree clean

   4. Compare all local and remote branches
      If you want to compare all branches at once (both local and remote), you can use:
      git commands - `git fetch --all` and `git diff --stat --name-only main..origin/main`
      E.g.
      $ git diff --stat --name-only main..origin/main
      README.md

   5. Compare the local branch with the remote branch
      command  - git diff <local-branch>..<remote>/<remote-branch>
      E.g.
      git diff main..origin/main
      E.g. output
      $ git diff main..origin/main
      diff --git a/README.md b/README.md
      index 635a75d..4eb0e4a 100644
      --- a/README.md
      +++ b/README.md
      @@ -1,2 +1,3 @@
      -# git-learning (Quick Steps)
      +# git-learning (Quick Steps)
      +## Github basic commands
   6. Check for differences in commits (Using **git log** command)
      If you want to see the commit differences between your local branch and the remote branch, you can use:
      git command - `git log <local-branch>..<remote>/<remote-branch>`
      E.g.
      git log <local-branch>..<remote>/<remote-branch>
      $ git log main..origin/main
      commit 9b999b4dbe4a66412033dce7aa2372ceae525d22 (origin/main, origin/HEAD)
      Author: Padmakar Kotule <padmakar.kotule@gmail.com>
      Date:   Wed Mar 19 10:52:29 2025 +0530
      Update README.md
      **This will show you the commits that are in the remote but not in your local branch, or vice versa.**


- `Example - git pull`**: Fetch the latest changes and merge them into your current branch.

---

### **Category 5: Handling Conflicts and Temporary Work**

These commands are useful when you want to temporarily save your work or handle merge conflicts.

| **Command**             | **Purpose**                                                        | **Example**                                                         |
|-------------------------|--------------------------------------------------------------------|---------------------------------------------------------------------|
| **`git stash`**          | Temporarily save your changes and revert your working directory to the last commit. | `git stash`                                                         |
| **`git rebase`**         | Reapply commits on top of another branch to maintain a clean history. | `git rebase main`                                                   |
| **`git reset`**          | Unstage changes or reset the current branch to a specific commit.    | `git reset --hard <commit-hash>`                                     |

#### **Explanation**:
- **`git stash`**: Temporarily save uncommitted changes and revert to the last commit (useful when switching tasks).
- **`git rebase`**: Rebase your current branch onto another branch to ensure a clean commit history.
- **`git reset`**: Unstage files or reset your branch to a previous state.


#### **Examples**:
- **`git stash`**: Temporarily save uncommitted changes and revert to the last commit (useful when switching tasks).
- **`git rebase`**: Rebase your current branch onto another branch to ensure a clean commit history.
- **`git reset`**: Unstage files or reset your branch to a previous state.
---

### **Category 6: Working with Tags and Remotes**

Commands in this category help you work with remote repositories and mark specific points in your commit history.

| **Command**             | **Purpose**                                                              | **Example**                                                          |
|-------------------------|--------------------------------------------------------------------------|----------------------------------------------------------------------|
| **`git remote`**         | Manage remote repositories (view, add, remove remotes).                 | `git remote add origin https://github.com/user/repository.git`        |
| **`git tag`**            | Tag a specific commit for marking important points like releases.       | `git tag v1.0`                                                        |
| **`git push --tags`**    | Push tags to the remote repository.                                     | `git push origin v1.0`                                                |

#### **Explanation**:
- **`git remote`**: View or manage the remote repositories you are connected to (e.g., `origin`).
- **`git tag`**: Create a tag for a specific commit (often used for releases).
- **`git push --tags`**: Push all local tags to the remote repository.

#### **Examples**:
- **`git remote`**: View or manage the remote repositories you are connected to (e.g., `origin`).
- **`git tag`**: Create a tag for a specific commit (often used for releases).
- **`git push --tags`**: Push all local tags to the remote repository.

---

### **Category 7: Cleaning Up and Removing Files**

Commands related to cleaning up files and removing them from the repository.

| **Command**             | **Purpose**                                                                 | **Example**                                                            |
|-------------------------|-----------------------------------------------------------------------------|------------------------------------------------------------------------|
| **`git rm`**             | Remove files from the working directory and staging area.                  | `git rm old_file.txt`                                                  |
| **`git clean`**          | Remove untracked files from the working directory.                         | `git clean -fd`                                                        |

#### **Explanation**:
- **`git rm`**: Remove files from both the working directory and staging area.
- **`git clean`**: Remove untracked files (useful for cleaning up your working directory).

#### **Examples**:
- **`git rm`**: Remove files from both the working directory and staging area.
- **`git clean`**: Remove untracked files (useful for cleaning up your working directory).

---

### **Git Workflow for Beginners (Summary)**

1. **Initialize or Clone Repository**:
   - `git init` (to start a new repo) or `git clone` (to clone an existing repo).
   
2. **Start Working with Branches**:
   - Use `git branch` to see the branches or `git checkout -b` to create a new branch and start working on it.
   
3. **Stage and Commit Changes**:
   - `git add` your changes, then `git commit` to save them locally.
   
4. **Push Your Changes to Remote**:
   - `git push` to upload your changes to a remote repository.

5. **Keep Your Repository Updated**:
   - Use `git pull` to bring in changes from the remote repository.

6. **Handle Conflicts**:
   - Use `git stash` to temporarily save your work if needed, or `git merge` to merge branches and resolve conflicts.

---

### Conclusion:

This categorization of Git commands helps beginners understand the logical flow of working with Git. By following this structure:

1. **Category 1: Initial Setup & Repository Management** (init or clone),
2. **Category 2: Working with Branches**
3. **Category 3: Staging, Committing, and Pushing Changes with tags**
4. **Category 4: Updating Your Local Repository** (Push changes to remote)
5. **Category 5: Handling Conflicts and Temporary Work** (stash, rebase), 
6. **Category 6: Working with Tags and Remotes** for collaboration.
7. **Category 7: Cleaning Up and Removing Files**
