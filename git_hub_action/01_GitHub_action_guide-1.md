Here's a **comprehensive step-by-step guide** to set up a GitHub Actions **self-hosted runner** and run a basic GitHub Actions pipeline with a job that simply echoes "starting pipeline".

---

## ✅ Overview

1. **Install dependencies** on your self-hosted machine
2. **Register the self-hosted runner** with GitHub
3. **Run the runner**
4. **Create a GitHub Actions workflow** (basic example)
5. **Test the setup**

---

## 🖥️ 1. Prepare Your Self-Hosted Machine

You can use:

* A local PC (Linux/macOS/Windows)
* A virtual machine or cloud instance

### ✅ Requirements

* Git installed
* User with permission to install software
* Internet access (to communicate with GitHub)

Install Git:

```bash
sudo apt update
sudo apt install git -y
```

Create a directory to store your runner:

```bash
mkdir actions-runner && cd actions-runner
```

---

## 🔧 2. Add a Self-Hosted Runner on GitHub

1. Go to your **GitHub repository**
2. Click **Settings > Actions > Runners**
3. Click **"New self-hosted runner"**
4. Choose your **OS**
5. GitHub will show you commands like:

### For Ubuntu/Linux:

```bash
# 1. Create a folder
mkdir actions-runner && cd actions-runner

# 2. Download the latest runner package
curl -o actions-runner-linux-x64-2.314.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.314.1/actions-runner-linux-x64-2.314.1.tar.gz

# 3. Extract the installer
tar xzf ./actions-runner-linux-x64-2.314.1.tar.gz

# 4. Configure the runner
./config.sh --url https://github.com/YOUR_USERNAME/YOUR_REPO --token YOUR_TOKEN

# 5. Start the runner
./run.sh
```

> Replace `YOUR_USERNAME/YOUR_REPO` and `YOUR_TOKEN` with your actual GitHub repo and token from the web interface.


1. **Download**
    ```bash
    # 1. Create a folder
    $ mkdir actions-runner && cd actions-runner

    # 2. Download the latest runner package
    $ curl -o actions-runner-linux-x64-2.324.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.324.0/actions-runner-linux-x64-2.324.0.tar.gz

    # 3. Optional: Validate the hash
    $ echo "e8e24a3477da17040b4d6fa6d34c6ecb9a2879e800aa532518ec21e49e21d7b4  actions-runner-linux-x64-2.324.0.tar.gz" | shasum -a 256 -c
    # 4. Extract the installer
    $ tar xzf ./actions-runner-linux-x64-2.324.0.tar.gz
    ```
2. Configure 
    # Create the runner and start the configuration experience
    $ ./config.sh --url https://github.com/PadmakarKotule-GSLab/my-project --token AQL2JTIOBJPLTFHISAB6BVDIHAEX2

    # Follow the on-screen commands to install and configure the runner. Example for Linux:
    # E.g.
    azureuser@ubuntu-vm01:~/actions-runner$ ./config.sh --url https://github.com/PadmakarKotule-GSLab/my-project --token AQL2JTIOBJPLTFHISAB6BVDIHAEX2

        --------------------------------------------------------------------------------
        |        ____ _ _   _   _       _          _        _   _                      |
        |       / ___(_) |_| | | |_   _| |__      / \   ___| |_(_) ___  _ __  ___      |
        |      | |  _| | __| |_| | | | | '_ \    / _ \ / __| __| |/ _ \| '_ \/ __|     |
        |      | |_| | | |_|  _  | |_| | |_) |  / ___ \ (__| |_| | (_) | | | \__ \     |
        |       \____|_|\__|_| |_|\__,_|_.__/  /_/   \_\___|\__|_|\___/|_| |_|___/     |
        |                                                                              |
        |                       Self-hosted runner registration                        |
        |                                                                              |
        --------------------------------------------------------------------------------

        # Authentication
        √ Connected to GitHub
        # Runner Registration
        Enter the name of the runner group to add this runner to: [press Enter for Default] testing
        Could not find any self-hosted runner group named "testing".
        azureuser@ubuntu-vm01:~/actions-runner$ ./config.sh --url https://github.com/PadmakarKotule-GSLab/my-project --token AQL2JTIOBJPLTFHISAB6BVDIHAEX2

        --------------------------------------------------------------------------------
        |        ____ _ _   _   _       _          _        _   _                      |
        |       / ___(_) |_| | | |_   _| |__      / \   ___| |_(_) ___  _ __  ___      |
        |      | |  _| | __| |_| | | | | '_ \    / _ \ / __| __| |/ _ \| '_ \/ __|     |
        |      | |_| | | |_|  _  | |_| | |_) |  / ___ \ (__| |_| | (_) | | | \__ \     |
        |       \____|_|\__|_| |_|\__,_|_.__/  /_/   \_\___|\__|_|\___/|_| |_|___/     |
        |                                                                              |
        |                       Self-hosted runner registration                        |
        |                                                                              |
        --------------------------------------------------------------------------------
        # Authentication
        √ Connected to GitHub
        # Runner Registration
        Enter the name of the runner group to add this runner to: [press Enter for Default]
        Enter the name of runner: [press Enter for ubuntu-vm01]
        This runner will have the following labels: 'self-hosted', 'Linux', 'X64'
        Enter any additional labels (ex. label-1,label-2): [press Enter to skip]
        √ Runner successfully added
        √ Runner connection is good
        # Runner settings
        Enter name of work folder: [press Enter for _work]
        √ Settings Saved.
        azureuser@ubuntu-vm01:~/actions-runner$

    # Last step, run it!
    $ ./run.sh    
3. Using your self-hosted runner
    # Use this YAML in your workflow file for each job
    runs-on: self-hosted
```
---

## 🔁 3. Run the Runner

To run the runner manually:

```bash
./run.sh
```

If you want it to run **as a service**, follow GitHub's instruction (shown after config), e.g.:

```bash
sudo ./svc.sh install
sudo ./svc.sh start
```

---

## 📄 4. Create a GitHub Actions Workflow

In your repository:

1. Go to `.github/workflows/` directory (create if missing)
2. Create a file like `basic-pipeline.yml`:

```yaml
name: Basic Pipeline

on:
  push:
    branches: [ main ]

jobs:
  hello-world:
    runs-on: self-hosted
    steps:
      - name: Start pipeline
        run: echo "starting pipeline"
```

---

## 🚀 5. Test the Setup

1. Commit and push this workflow:

```bash
git add .github/workflows/basic-pipeline.yml
git commit -m "Add basic pipeline"
git push origin main
```

2. On push, GitHub will:

   * Trigger the action
   * Assign the job to your self-hosted runner
   * Execute the `echo "starting pipeline"` command

3. Check the Actions tab on GitHub to monitor the run.

---

## ✅ Optional: Run the Runner as a Service

To make sure the runner restarts with system boot:

```bash
cd actions-runner
sudo ./svc.sh install
sudo ./svc.sh start
```

---

## 🧹 Cleanup

To remove the runner:

```bash
./config.sh remove
```

---

## 🧠 Tips

* You can register multiple runners on different machines or use labels to specialize them.
* Security: Self-hosted runners can be a security risk for public repos. Use only on private repos or secure environments.
* Monitoring logs: `./run.sh` will print logs to terminal. Use logging or redirection if needed.

---

Would you like a Docker-based version, or help setting up auto-restart, systemd unit file, or GitHub organization-wide runners?
