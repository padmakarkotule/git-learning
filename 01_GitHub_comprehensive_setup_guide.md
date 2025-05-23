# GitHub Comprehensive Setup Guide.

To start using GitHub, here are the basic prerequisites and steps:

1. **Prerequisites to Start with GitHub**
2. **Installing Git**
3. **Setting up SSH keys**
4. **Creating a GitHub repository**
5. **Connecting your local machine to GitHub via SSH**
6. **Commit and push changes**
7. **Working with branches**

---

### **Step 1: Prerequisites to Start with GitHub**

   **Basic Understanding of Version Control** (Recommended)

      * Know what **Git** is and how version control systems work.
      * Not mandatory to start, but very helpful.

   **Email Address**

      * You'll need a valid email to create a GitHub account and verify it.

   **Create a GitHub Account**

      * Go to: [https://github.com](https://github.com)
      * Click **Sign up**.
      * Enter your email, create a username and password, and follow the verification steps.

   **(Optional but Helpful) Install a Code Editor E.g. VS Code**

      * Install **Visual Studio Code** or another text/code editor.
      * VS Code has built-in Git support and GitHub integration.

   **Login to GitHub and verify everything is working fine.**

      * Verify everything is working fine and able to login to GitHub portal
      * Also make sure you have configure 2 Factor authentication and kept the initial code safely.
        You can use your phone number to receive sms or you can configure Authenticator App.

---

### **Step 2: Install Git**

If you haven't already installed Git on your system, here's how you can do it:

1. **Download Git**:
   - Go to [https://git-scm.com/downloads](https://git-scm.com/downloads) and download the appropriate version for your operating system (Windows, Mac, or Linux).

2. **Install Git**:
   - Run the installer and follow the steps in the installation wizard.
   - During the installation, you can leave the default options selected (unless you want to customize).
   - Once installed, **open Git Bash** (on Windows) or your terminal (on Mac/Linux) to run Git commands.

---

3. **Configure Git**

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



4. **Verify the configuration** (optional, to make sure everything is set up):

```bash
git config --global --list
```

---

### **Step 3: Setting up SSH keys (Generate SSH Key & Add the SSH Key to GitHub)**

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

#### 3.3 Add SSH Key to GitHub**

Now, we need to add your SSH key to GitHub so you can authenticate without entering your credentials each time.

#### Copy the SSH Public Key

1. **Display the public key**:

```bash
cat ~/.ssh/id_rsa.pub
```

This will show your public SSH key. It will look like this:

```
ssh-rsa AAAAB3... rest of the key ... your_email@example.com
```

2. **Copy the entire key** (from `ssh-rsa` to your email address).

#### 3.4 Add the SSH Key to GitHub

1. Go to **GitHub** and log in to your account.
2. In the top-right corner of GitHub, click on your profile picture and choose **Settings**.
3. On the left sidebar, click **SSH and GPG keys**.
4. Click the **New SSH key** button.
5. Paste the copied key into the **Key** field and give it a **Title** (e.g., "My Laptop Key").
6. Click **Add SSH key**.

#### 3.5 Test the SSH Connection

Run the following command to verify that your SSH key is working:

```bash
ssh -T git@github.com
```

If everything is set up correctly, you should see a message like this:

```
Hi username! You've successfully authenticated, but GitHub does not provide shell access.

E.g.
Hi padmakarkotule! You've successfully authenticated, but GitHub does not provide shell access.

```

This means you’ve successfully set up SSH for GitHub!

---

### **Step 4: Create a GitHub Repository**

Now, let's create a remote repository on GitHub where you’ll push your code.

1. Go to **GitHub** and log in.
2. Click on the **+** in the top-right corner and select **New repository**.
3. Name your repository (e.g., `my-project`).
4. Choose **Public** or **Private** (depends on your preference).
5. Do not initialize with a README or any other files.
6. Click **Create repository**.

Once the repository is created, GitHub will show you the **URL** to connect to it. You'll use this to link your local project with the remote GitHub repository.

---

### **Step 5: Connect Local Repository to GitHub**

#### 5.1 Initialize Your Local Repository

If you haven't yet initialized your local project as a Git repository, do so now:

1. Navigate to your project folder:

```bash
cd path/to/your/project
```

2. Initialize Git:

```bash
git init
```

#### 5.2 Add Remote Repository (GitHub)

Now you need to connect your local repository to the remote GitHub repository. You’ll use the SSH URL provided by GitHub when you created the repository.

1. Copy the **SSH URL** of your GitHub repository (it should look like `git@github.com:username/my-project.git`).
   E.g.

2. Run the following command in your Git Bash or terminal:

```bash
git remote add origin git@github.com:username/my-project.git

E.g.
   git remote add origin git@github.com:PadmakarKotule-GSLab/my-project.git
```

#### 5.3 Verify the Remote Connection

You can verify that the remote was added correctly by running:

```bash
git remote -v
```

This should display the URL of your GitHub repository.

---

### **Step 6: Commit and push changes - Make Your First Commit**

#### 6.1 Create or Edit Files

Now let’s make your first commit. Create or edit a file, such as a `README.md`:

```bash
echo "# My Project" > README.md
```

#### 6.2 Stage and Commit the Changes

1. **Stage** the file for commit:

```bash
git add README.md
```

2. **Commit** the changes:

```bash
git commit -m "Initial commit"
```

#### 6.3 Push your code from local to GitHub
Now that you have committed your changes, you need to **push** them to your GitHub repository.

```bash
git push -u origin master  # Or 'main' if you are using the default branch 'main'

E.g.
   git push -u origin master
```

- Since you are using SSH, Git will authenticate automatically using your SSH key.

---

#### 6.4 Verify on GitHub**

1. Go to your **GitHub repository page**.
2. You should now see your `README.md` file (or any other file you added).
3. This confirms that your local changes were successfully pushed to GitHub!

---

### **Step 7: Working with Branches**

When **working on new features or fixes, it’s common practice to use **branches**.
By default when you use "git init" it's create branch as master
You can rename this branch from "master" to "main"

Generally you need to follow the standard Git workflow with the following sequence,

- **Feature branches** are merged into the **`dev`** branch.
- After testing and stability, the **`dev`** branch is merged into the **`release`** branch.
- Finally, the **`release`** branch is merged into the **`main`** branch for deployment or production-ready code.

This workflow is common in many teams and allows for better separation of different stages of development.
This process ensures that you're using a structured workflow to manage your development, testing, and production stages effectively. Each branch has its purpose, and the merges are controlled for stability before deploying to `main`. 

**Note** - You must use the tags for every commit, so that you can build artificat such as docker image using same tag.

### **Summary of Steps**:

1. **Prerequisites to Start with GitHub**
2. **Installing Git**
3. **Setting up SSH keys**
4. **Creating a GitHub repository**
5. **Connecting your local machine to GitHub via SSH**
6. **Commit and push changes**
7. **Working with branches**
