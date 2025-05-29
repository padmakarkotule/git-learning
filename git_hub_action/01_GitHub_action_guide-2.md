Here's a **comprehensive step-by-step guide** to set up a **GitHub Actions self-hosted runner** and run a **basic pipeline** that echoes "starting pipeline":

---

## 🛠️ PART 1: Set Up a GitHub Actions Self-Hosted Runner

### ✅ Prerequisites

* A GitHub account
* A repository where you'll set up the Actions workflow
* A machine (VM or physical) to run the self-hosted runner:

  * OS: Linux, macOS, or Windows
  * Internet access
  * `bash` (or PowerShell on Windows)
  * `curl`, `tar` (for Linux/macOS)

---

### 🔧 Step 1: Create a GitHub Repository

1. Go to [https://github.com](https://github.com) and log in.
2. Click `New repository`.
3. Give it a name (e.g., `actions-self-hosted-runner`).
4. Initialize it with a `README.md` (optional).
5. Click `Create repository`.

---

### 🖥️ Step 2: Prepare the Self-Hosted Runner Machine

> 📝 You'll install the runner on the machine where you want jobs to run.

1. Navigate to your GitHub repository.
2. Go to **Settings** → **Actions** → **Runners**.
3. Click **"New self-hosted runner"**.
4. Choose your **operating system**.
5. Follow the **on-screen commands** to install and configure the runner. Example for Linux:

```bash
# Create a directory
mkdir actions-runner && cd actions-runner

# Download the runner
curl -o actions-runner-linux-x64-2.314.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.314.1/actions-runner-linux-x64-2.314.1.tar.gz

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.314.1.tar.gz

# Configure the runner (replace URL and TOKEN)
./config.sh --url https://github.com/YOUR_USERNAME/YOUR_REPO --token YOUR_GENERATED_TOKEN

# Start the runner
./run.sh
```

> ⚠️ **Important**: This runner will stay active only while the terminal session is open. To run it as a service (for auto-start), follow the additional GitHub instructions under **Configure as a service**.

---

## 🧪 PART 2: Create a Basic GitHub Actions Pipeline

### 📁 Step 3: Add a Workflow File

1. In your repo root, create this directory structure:

```
.github/
└── workflows/
    └── hello-runner.yml
```

2. Create the file `.github/workflows/hello-runner.yml` with the following content:

```yaml
name: Self-Hosted Runner Test

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  echo-job:
    name: Echo Start Message
    runs-on: self-hosted
    steps:
      - name: Say Hello
        run: echo "starting pipeline"
```

---

## 🚀 Step 4: Trigger the Workflow

You have two options:

### Option A: Push a Commit to `main`

```bash
git add .
git commit -m "Add self-hosted runner test workflow"
git push origin main
```

### Option B: Manually Trigger It

1. Go to the repo on GitHub.
2. Click on the **Actions** tab.
3. Find the workflow named **"Self-Hosted Runner Test"**.
4. Click **Run workflow** → Choose branch → Click **Run workflow**.

---

## ✅ Step 5: See the Runner in Action

* Watch the job execute in the **Actions** tab.
* If set up correctly, it will use your self-hosted machine and log:

  ```
  starting pipeline
  ```

---

## 🧹 Optional: Configure the Runner as a Service

To keep the runner available without manually starting it every time:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
```

This will register it as a system service (Linux/macOS) or Windows service.

---

## 🔚 Summary

| Step | Action                          |
| ---- | ------------------------------- |
| 1    | Create a repo                   |
| 2    | Register a self-hosted runner   |
| 3    | Install & configure runner      |
| 4    | Create a workflow file          |
| 5    | Trigger workflow                |
| 6    | Verify job runs on your machine |

Would you like help setting this up on a specific OS (e.g., Windows or Ubuntu)?
