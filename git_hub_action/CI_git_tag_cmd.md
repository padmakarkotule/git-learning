Once you've created and pushed a Git **tag**, you can **clone, checkout**, or **pull that exact version** of the code, and use it to **build a Docker image** — this is a common and reliable CI/CD pattern.

---

## 🚀 Step-by-Step: Clone and Build from Tagged Version

### 🔁 1. Clone the Repo

```bash
git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>

E.g.
git clone git@github.com:padmakarkotule/branching-strategy-lab.git
cd branching-strategy-lab/
```
---

### 🔎 2. List Tags (Optional)

```bash
git tag

E.g.
$ git tag
v1.0.1

```

> This will list all available tags like `v1.0.1`, `v1.0.2-hotfix`, etc.

---

### 📥 3. Checkout the Tag

```bash
git checkout tags/v1.0.1 -b build/v1.0.1
```

> ✅ This creates a new branch `build/v1.0.1` from the tag so you can build and make temporary changes if needed.

---

### 🐳 4. Build Docker Image

Assuming you have a `Dockerfile` in your repo root:

```bash
docker build -t your-app:v1.0.1 .
E.g.
docker build -t myweb:v1.0.1
docker build . -t identitydesk.azurecr.io/helphive_backend_chat:v1.0.1
```

Now your image is tagged with the same version as your Git release — great for traceability.

---

### (Optional) Push to Docker Registry

```bash
# Use following command if you have not used -t and registory in that command.
docker tag your-app:v1.0.1 your-registry/your-app:v1.0.1
#
docker push your-registry/your-app:v1.0.1
E.g.
docker push identitydesk.azurecr.io/helphive_backend_chat:1.0.2
```

---

## Why This Works Well

| Benefit                    | Description                                        |
| -------------------------- | -------------------------------------------------- |
| **Immutable versions**  | Tags point to exact code states — no surprises     |
| **Reproducible builds** | Anyone can build the same image using the same tag |
| **Safe for production** | You know exactly what was deployed and when        |

---
