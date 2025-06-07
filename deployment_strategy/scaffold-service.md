Absolutely! Below is a fully documented `scaffold-service.sh` script. It helps you **quickly bootstrap a new service structure** across `dockerfiles/`, `helm-charts/`, `raw_k8s_manifests/`, `kustomize/`, and `scripts/envs/` by using sensible defaults and templates.

---

## ✅ `scripts/scaffold-service.sh`

```bash
#!/bin/bash
set -e

# ──────────────────────────────────────────────
# This script scaffolds a new service structure
# in a devops-infra-setup repository
# ──────────────────────────────────────────────

# Usage: ./scripts/scaffold-service.sh service-name

SERVICE_NAME="$1"

if [[ -z "$SERVICE_NAME" ]]; then
  echo "❌ Usage: $0 <service-name>"
  exit 1
fi

BASE_DIR=$(pwd)
ENV_DIR="${BASE_DIR}/services/${SERVICE_NAME}"
DOCKERFILE_DIR="${BASE_DIR}/dockerfiles"
HELM_DIR="${BASE_DIR}/helm-charts/${SERVICE_NAME}"
RAW_K8S_DIR="${BASE_DIR}/raw_k8s_manifests/${SERVICE_NAME}"
KUSTOMIZE_DIR="${BASE_DIR}/kustomize/${SERVICE_NAME}"
SCRIPT_DIR="${BASE_DIR}/scripts"

echo "🚧 Scaffolding service: $SERVICE_NAME..."

# ─── Create ENV file ─────────────────────────────
mkdir -p "$ENV_DIR"
cat > "${ENV_DIR}/${SERVICE_NAME}.env" <<EOF
# --------------------------------------
# .env file for ${SERVICE_NAME}
# --------------------------------------

REMOTE_REPO_URL=https://github.com/your-org/${SERVICE_NAME}.git
REMOTE_REPO_BRANCH=main
REMOTE_REPO_DIR=workspace
SERVICE_VERSION_FILE=service_version.txt

DOCKER_IMAGE_NAME=${SERVICE_NAME}
DOCKER_REGISTRY=yourregistry.azurecr.io
DOCKERFILE_PATH=./dockerfiles/${SERVICE_NAME}.Dockerfile

SONAR_ENABLED=true
SONAR_URL=http://sonar.yourdomain.com
SONAR_TOKEN=your-sonar-token
SONAR_BRANCH=dev

HELM_REPO_URL=yourregistry.azurecr.io
HELM_CHART_DIR=helm-charts/${SERVICE_NAME}

GITHUB_REPO=your-org/${SERVICE_NAME}
GITHUB_API_WRITE_TOKEN=your-github-token
EOF
echo "✅ .env file created at ${ENV_DIR}/${SERVICE_NAME}.env"

# ─── Create Dockerfile ──────────────────────────
mkdir -p "$DOCKERFILE_DIR"
cat > "${DOCKERFILE_DIR}/${SERVICE_NAME}.Dockerfile" <<EOF
# Dockerfile for ${SERVICE_NAME}
FROM openjdk:17-jdk-slim

WORKDIR /app
COPY . /app

CMD ["java", "-jar", "${SERVICE_NAME}.jar"]
EOF
echo "✅ Dockerfile created at ${DOCKERFILE_DIR}/${SERVICE_NAME}.Dockerfile"

# ─── Create Helm chart ──────────────────────────
mkdir -p "${HELM_DIR}/templates"
cat > "${HELM_DIR}/Chart.yaml" <<EOF
apiVersion: v2
name: ${SERVICE_NAME}
description: Helm chart for ${SERVICE_NAME}
version: 0.1.0
appVersion: "1.0.0"
EOF

cat > "${HELM_DIR}/values.yaml" <<EOF
replicaCount: 1

image:
  repository: yourregistry.azurecr.io/${SERVICE_NAME}
  tag: "latest"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 80
EOF

cat > "${HELM_DIR}/templates/deployment.yaml" <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Chart.Name }}
  template:
    metadata:
      labels:
        app: {{ .Chart.Name }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: 8080
EOF
echo "✅ Helm chart created in ${HELM_DIR}/"

# ─── Create Raw Kubernetes Manifests ────────────
mkdir -p "${RAW_K8S_DIR}"
cat > "${RAW_K8S_DIR}/deployment.yaml" <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${SERVICE_NAME}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${SERVICE_NAME}
  template:
    metadata:
      labels:
        app: ${SERVICE_NAME}
    spec:
      containers:
        - name: ${SERVICE_NAME}
          image: yourregistry.azurecr.io/${SERVICE_NAME}:latest
          ports:
            - containerPort: 8080
EOF
echo "✅ Raw Kubernetes manifests created in ${RAW_K8S_DIR}/"

# ─── Create Kustomize Structure ─────────────────
mkdir -p "${KUSTOMIZE_DIR}/base" "${KUSTOMIZE_DIR}/overlays/dev"
cat > "${KUSTOMIZE_DIR}/base/kustomization.yaml" <<EOF
resources:
  - ../../raw_k8s_manifests/${SERVICE_NAME}/deployment.yaml
EOF

cat > "${KUSTOMIZE_DIR}/overlays/dev/kustomization.yaml" <<EOF
bases:
  - ../../base
EOF
echo "✅ Kustomize setup created in ${KUSTOMIZE_DIR}/"

echo "🎉 Scaffold complete for service: ${SERVICE_NAME}"
```

---

## 🔍 What This Script Does

| Feature           | Output                                                       |
| ----------------- | ------------------------------------------------------------ |
| `.env`            | `services/<service>/service.env` with all required variables |
| Dockerfile        | In `dockerfiles/<service>.Dockerfile`                        |
| Helm Chart        | Minimal Helm chart under `helm-charts/<service>/`            |
| Raw K8s Manifests | Basic `deployment.yaml` in `raw_k8s_manifests/<service>/`    |
| Kustomize         | `base/` and `overlays/dev/` under `kustomize/<service>/`     |

---

## 🚀 How to Use

```bash
chmod +x scripts/scaffold-service.sh
./scripts/scaffold-service.sh service-x
```

This will create all required files and folders for `service-x`.

---

Would you like me to also generate a `README.md` template per service that explains where each file fits in your workflow?
