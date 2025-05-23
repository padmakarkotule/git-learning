No problem! Let's walk through the **entire sequence from start to finish**, step-by-step, including everything from **setting up Git** to **generating and configuring SSH keys**, and finally pushing your code to a remote GitHub repository.

This guide will be **comprehensive** for someone new to Git. We’ll cover:

1. **Installing Git**
2. **Setting up SSH keys**
3. **Creating a GitHub repository**
4. **Connecting your local machine to GitHub via SSH**
5. **Commit and push changes**
6. **Working with branches**

---

### **Step 1: Install Git**

If you haven't already installed Git on your system, here's how you can do it:

1. **Download Git**:
   - Go to [https://git-scm.com/downloads](https://git-scm.com/downloads) and download the appropriate version for your operating system (Windows, Mac, or Linux).

2. **Install Git**:
   - Run the installer and follow the steps in the installation wizard.
   - During the installation, you can leave the default options selected (unless you want to customize).
   - Once installed, **open Git Bash** (on Windows) or your terminal (on Mac/Linux) to run Git commands.

---

### **Step 2: Configure Git**

Before using Git, you need to set your name and email. These details will be associated with your commits.

1. **Set your name** (appears in commit history):

```bash
git config --global user.name "Your Name"
```

2. **Set your email** (this should be the same email you used for GitHub):

```bash
git config --global user.email "your_email@example.com"
```
   **Note:**
      you're managing **multiple GitHub accounts** (like `org1`, `proj2`, and `personal`) and want to know:

      1. How to **check which GitHub account is currently "active"** on your system
      2. How to **switch between accounts**
      3. How to **start a new project** using the correct account

      ---

      ## ✅ 1. Check Which GitHub Account is Logged In (Git CLI)

      Git itself doesn’t "log in" — it just uses credentials when pushing to remotes. You can check the current Git identity like this:

      ```bash
      git config --global user.name
      git config --global user.email
      ```

      But this shows the **default (global)** identity. For a specific repo:

      ```bash
      git config user.name
      git config user.email
      ```

      If this returns nothing, Git uses the global config.

      ---

      ## 🔄 2. Switch Between GitHub Accounts

      ### 🔸 Option A: Use Per-Project Config

      For each project, set the correct user:

      ```bash
      git config user.name "Your Name"
      git config user.email "your-email@org1.com"
      ```

      This saves it to `.git/config` (local to the repo), overriding the global one.

      ---

      ### 🔸 Option B: Use SSH for Multiple GitHub Accounts

      If you're pushing/pulling to/from **multiple GitHub accounts**, it's best to configure **SSH aliases**:

      #### **Follow step 3, Generate a separate SSH key per account**

   ## ****



3. **Verify the configuration** (optional, to make sure everything is set up):

```bash
git config --global --list
```

---

### **Step 3: Generate SSH Key**

To authenticate with GitHub without entering your username and password every time, you'll generate an SSH key.

#### 3.1 Generate SSH Key Pair

1. Open **Git Bash** (or your terminal) and run the following command:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
E.g.
 ssh-keygen -t rsa -b 4096 -C "padmakar.kotule@gslab.com"
   Generating public/private rsa key pair.
   Enter file in which to save the key (/c/Users/gs-1062/.ssh/id_rsa): /c/Users/gs-1062/.ssh/id_rsa_padmakar-gslab-github

```

- **`-t rsa`**: Specifies the type of key to create (RSA).
- **`-b 4096`**: Specifies the length of the key (4096 bits).
- **`-C "your_email@example.com"`**: Adds a label to the key for identification (your email).

2. You’ll see a prompt asking where to save the key. Press **Enter** to accept the default location:

```
/c/Users/YourUser/.ssh/id_rsa
```

3. You’ll also be asked if you want to set a **passphrase** for the key. This is optional, but it’s recommended for added security.

#### 3.2 Add the SSH Key to the SSH Agent

To make sure your SSH key is used by Git, you need to add it to the SSH agent.

1. **Start the SSH agent** (in Git Bash):

```bash
eval "$(ssh-agent -s)"
```

2. **Add the SSH private key to the agent**:

```bash
ssh-add ~/.ssh/id_rsa
   E.g.
   $ ssh-add ~/.ssh/id_rsa_padmakar-gslab-github
   Identity added: /c/Users/gs-1062/.ssh/id_rsa_padmakar-gslab-github (padmakar.kotule@gslab.com)

```

---

### **Step 4: Add SSH Key to GitHub**

Now, we need to add your SSH key to GitHub so you can authenticate without entering your credentials each time.

#### 4.1 Copy the SSH Public Key

1. **Display the public key**:

```bash
cat ~/.ssh/id_rsa.pub
```

This will show your public SSH key. It will look like this:

```
ssh-rsa AAAAB3... rest of the key ... your_email@example.com
```

2. **Copy the entire key** (from `ssh-rsa` to your email address).

#### 4.2 Add the SSH Key to GitHub

1. Go to **GitHub** and log in to your account.
2. In the top-right corner of GitHub, click on your profile picture and choose **Settings**.
3. On the left sidebar, click **SSH and GPG keys**.
4. Click the **New SSH key** button.
5. Paste the copied key into the **Key** field and give it a **Title** (e.g., "My Laptop Key").
6. Click **Add SSH key**.

#### 4.3 Test the SSH Connection

Run the following command to verify that your SSH key is working:

```bash
ssh -T git@github.com
```

If everything is set up correctly, you should see a message like this:

```
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

This means you’ve successfully set up SSH for GitHub!

---

### **Step 5: Create a GitHub Repository**

Now, let's create a remote repository on GitHub where you’ll push your code.

1. Go to **GitHub** and log in.
2. Click on the **+** in the top-right corner and select **New repository**.
3. Name your repository (e.g., `my-project`).
4. Choose **Public** or **Private** (depends on your preference).
5. Do not initialize with a README or any other files.
6. Click **Create repository**.

Once the repository is created, GitHub will show you the **URL** to connect to it. You'll use this to link your local project with the remote GitHub repository.

---

### **Step 6: Connect Local Repository to GitHub**

#### 6.1 Initialize Your Local Repository

If you haven't yet initialized your local project as a Git repository, do so now:

1. Navigate to your project folder:

```bash
cd path/to/your/project
```

2. Initialize Git:

```bash
git init
```

#### 6.2 Add Remote Repository (GitHub)

Now you need to connect your local repository to the remote GitHub repository. You’ll use the SSH URL provided by GitHub when you created the repository.

1. Copy the **SSH URL** of your GitHub repository (it should look like `git@github.com:username/my-project.git`).
2. Run the following command in your Git Bash or terminal:

```bash
git remote add origin git@github.com:username/my-project.git

E.g.
   git remote add origin git@github.com:PadmakarKotule-GSLab/my-project.git
```

#### 6.3 Verify the Remote Connection

You can verify that the remote was added correctly by running:

```bash
git remote -v
```

This should display the URL of your GitHub repository.

---

### **Step 7: Make Your First Commit**

#### 7.1 Create or Edit Files

Now let’s make your first commit. Create or edit a file, such as a `README.md`:

```bash
echo "# My Project" > README.md
```

#### 7.2 Stage and Commit the Changes

1. **Stage** the file for commit:

```bash
git add README.md
```

2. **Commit** the changes:

```bash
git commit -m "Initial commit"
```

---

### **Step 8: Push Your Code to GitHub**

Now that you have committed your changes, you need to **push** them to your GitHub repository.

```bash
git push -u origin master  # Or 'main' if you are using the default branch 'main'

E.g.
   git push -u origin master
```

- Since you are using SSH, Git will authenticate automatically using your SSH key.

---

### **Step 9: Verify on GitHub**

1. Go to your **GitHub repository page**.
2. You should now see your `README.md` file (or any other file you added).
3. This confirms that your local changes were successfully pushed to GitHub!

---

### **Step 10: Working with Branches**

When working on new features or fixes, it’s common practice to use **branches**.
By default when you use "git init" it's create branch as master
You can rename this branch from "master" to "main"

#### 10.1 Create a New Branch

Create and switch to a new branch for your feature or task:

```bash
git checkout -b feature/awesome-feature
```

#### 10.2 Make Changes and Commit

1. Make your changes (e.g., edit `README.md` or add new files).
2. **Stage** the changes:

```bash
git add .
```

3. **Commit** the changes:

```bash
git commit -m "Added awesome feature"
```

#### 10.3 Push the New Branch

Push your feature branch to GitHub:

```bash
git push -u origin feature/awesome-feature
```

---

### **Step 11: Merge Changes**

Once your feature is done and tested, you can merge it back into the `main` branch:

1. **Switch back to `main`** (or `master`):

```bash
git checkout main
```

2. **Merge the feature branch** into `main`:

```bash
git merge feature/awesome-feature
```

3. **Push** the changes to GitHub:

```bash
git push origin main
```


#### Let's modify Step 11 to follow a more standard Git workflow with the following sequence:

- Feature branches are merged into the dev branch.
- After testing and stability, the dev branch is merged into the release branch.
- Finally, the release branch is merged into the main branch for deployment or production-ready code.
This workflow is common in many teams and allows for better separation of different stages of development.
---

### **Step 12: Clean Up (Optional)**

After merging the feature branch, you can delete it locally and remotely:

```bash
# Delete the branch locally
git branch -d feature/awesome-feature

# Delete the branch remotely
git push origin --delete feature/awesome-feature
```

---

### **Summary of Steps**:

1. **Install Git**
2. **Configure Git** (name and email)
3. **Generate SSH Key** (`ssh-keygen`)
4. **Add SSH Key to GitHub**
5. **Create a GitHub repository**
6. **Initialize local repo** (`git init`)
7. **Add remote repo** (`git remote add origin`)

# Step 11
Certainly! Let's modify **Step 11** to follow a more standard Git workflow with the following sequence:

- **Feature branches** are merged into the **`dev`** branch.
- After testing and stability, the **`dev`** branch is merged into the **`release`** branch.
- Finally, the **`release`** branch is merged into the **`main`** branch for deployment or production-ready code.

This workflow is common in many teams and allows for better separation of different stages of development.

---

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

# PR Process 