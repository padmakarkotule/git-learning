# To use the full CI/CD pipeline with portable scripts, you need to ensure a few **infrastructure and access prerequisites** are ready across your environment.

---

## ✅ Pre-requisites for Using the Portable CI 

1. **Docker Registry Setup**
2. **Helm Repository (OCI-based)**
3. **Remote Git Repositories**
4. **SonarQube Setup (Optional but Supported)**
5. **GitHub Release Access**
6. **.env Configuration per Service**
7. **Configuration of agents. E.g. Jenkins Agent Requirements, or GitHub action self-runner**

### 1. **Docker Registry Setup**

* ✅ You must have a Docker registry (e.g., Azure Container Registry, AWS ECR, DockerHub, etc.).
* 🔒 Jenkins agents/nodes must be authenticated and authorized to **push Docker images**.

  * For Azure: `az acr login -n <registry-name>` or service principal auth.
  * For GCP: `gcloud auth configure-docker`.
  * For DockerHub: `docker login`.

---

### 2. **Helm Repository (OCI-based)**

* ✅ Helm OCI-compatible repository must exist (e.g., Azure ACR, Harbor, ChartMuseum).
* 📦 Helm CLI must be installed on the build agent (`helm version`).
* 🔒 Auth must be configured to **push Helm charts**:

  * For Azure: Helm supports ACR push with `az acr login`.
  * Helm OCI support must be enabled:

    ```bash
    export HELM_EXPERIMENTAL_OCI=1
    ```

---

### 3. **Remote Git Repositories**

* ✅ Your Jenkins agent must have **SSH access** to:

  * Remote source code repositories
  * Helm chart repos (e.g., `common-helm-devops`)
  * Tracking repos for `helm_version.txt`
* ✅ SSH key must be either in Jenkins credentials or the agent’s `~/.ssh/id_rsa`.

---

### 4. **SonarQube Setup (Optional but Supported)**

* If `SONAR_ENABLED=true`, make sure:

  * ✅ `SONAR_URL` is reachable from the Jenkins agent.
  * ✅ A valid `SONAR_TOKEN` is stored in Jenkins credentials or passed via env.
  * ✅ Your Dockerfile handles Sonar Scanner CLI if required.

---

### 5. **GitHub Release Access**

* ✅ GitHub Personal Access Token (with `repo` scope) must be available.
* ✅ `GITHUB_API_WRITE_TOKEN` must be passed via environment variable or secret.
* ✅ GitHub API must be reachable (`https://api.github.com`).

---

### 6. **.env Configuration per Service**

Each service must have an `.env` file with correctly set values:

```bash
REMOTE_REPO_URL=
REMOTE_REPO_BRANCH=
REMOTE_REPO_DIR=
DOCKER_IMAGE_NAME=
DOCKERFILE_PATH=
SERVICE_VERSION_FILE=
DOCKER_REGISTRY=
HELM_CHART_DIR=
HELM_REPO_URL=
GITHUB_REPO=
GITHUB_API_WRITE_TOKEN=
SONAR_ENABLED=true
SONAR_URL=
SONAR_TOKEN=
SONAR_BRANCH=
SERVICE_VERSION=
```

---

### 7. **Jenkins Agent Requirements**

Jenkins nodes used for build must have:

* ✅ Docker CLI installed and running
* ✅ Helm CLI installed
* ✅ `git`, `curl`, `jq` installed
* ✅ SSH access to all relevant GitHub repositories
* ✅ Internet access if pushing to GitHub or public registry
* ✅ Required secrets (tokens, SSH keys) injected via environment or Jenkins credentials

---

## ✅ Recommended Checks

| Check         | Command                                                              | Purpose                             |
| ------------- | -------------------------------------------------------------------- | ----------------------------------- |
| Docker access | `docker info`                                                        | Verify Docker daemon is usable      |
| Helm access   | `helm version`                                                       | Ensure Helm is installed            |
| GitHub access | `curl -H "Authorization: Bearer $TOKEN" https://api.github.com/user` | Validate GitHub PAT                 |
| Helm login    | `helm registry login <host>`                                         | Confirm access to Helm OCI registry |
| Git clone     | `git ls-remote git@github.com:your/repo.git`                         | Verify SSH access to GitHub         |
| Helm push     | `helm push mychart.tgz oci://youracr.azurecr.io`                     | Verify chart repo access            |

---

Would you like a **pre-flight check script** to run in Jenkins before the pipeline starts? That could automate these validations.
