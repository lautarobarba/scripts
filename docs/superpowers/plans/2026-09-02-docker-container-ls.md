# Docker Container Listing Script Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Crear un script Bash que liste todos los contenedores Docker con columnas simplificadas y puertos normalizados.

**Architecture:** El script solicita una fila delimitada a Docker por cada contenedor y procesa sólo la columna de puertos. Un archivo de prueba Bash sustituye el binario `docker` mediante `PATH` para verificar la transformación sin requerir un daemon Docker.

**Tech Stack:** Bash, Docker CLI, awk y pruebas Bash autónomas.

---

### Task 1: Probar la representación de puertos

**Files:**
- Create: `tests/docker_container_ls_test.sh`
- Test: `tests/docker_container_ls_test.sh`

- [ ] **Step 1: Write the failing test**

```bash
#!/usr/bin/env bash
set -euo pipefail

workspace_dir=$(cd "$(dirname "$0")/.." && pwd)
mock_dir=$(mktemp -d)
trap 'rm -rf "$mock_dir"' EXIT

cat >"$mock_dir/docker" <<'MOCK'
#!/usr/bin/env bash
printf 'web|nginx:latest|2 hours ago|Up 2 hours|0.0.0.0:8000->8080/tcp, 80/tcp\n'
printf 'api|example/api:1.0|3 hours ago|Up 3 hours|8080/tcp, 9000/tcp\n'
printf 'empty|alpine:latest|4 hours ago|Exited (0) 1 hour ago|\n'
MOCK
chmod +x "$mock_dir/docker"

actual=$(PATH="$mock_dir:$PATH" "$workspace_dir/docker_container_ls.sh")
expected=$'NAME|IMAGE|CREATED|STATUS|PORTS\nweb|nginx:latest|2 hours ago|Up 2 hours|8000->8080, X->80\napi|example/api:1.0|3 hours ago|Up 3 hours|X->8080, X->9000\nempty|alpine:latest|4 hours ago|Exited (0) 1 hour ago|X'

[[ "$actual" == "$expected" ]]
```

- [ ] **Step 2: Run test to verify it fails**

Run: `bash tests/docker_container_ls_test.sh`

Expected: FAIL because `docker_container_ls.sh` does not exist.

- [ ] **Step 3: Commit the failing test**

```bash
git add tests/docker_container_ls_test.sh
git commit -m "test: cover docker container summary ports"
```

### Task 2: Implementar el listado y normalización

**Files:**
- Create: `docker_container_ls.sh`
- Test: `tests/docker_container_ls_test.sh`

- [ ] **Step 1: Write minimal implementation**

```bash
#!/usr/bin/env bash
set -euo pipefail

printf 'NAME|IMAGE|CREATED|STATUS|PORTS\n'
docker container ls -a --format '{{.Names}}|{{.Image}}|{{.RunningFor}}|{{.Status}}|{{.Ports}}' |
  awk -F'|' '
  function port_summary(ports, items, count, index, item, result) {
    if (ports == "") return "X"
    count = split(ports, items, ", ")
    for (index = 1; index <= count; index++) {
      item = items[index]
      sub(/^.*:/, "", item)
      sub(/\\/.*$/, "", item)
      if (items[index] !~ /->/) item = "X->" item
      result = result (result ? ", " : "") item
    }
    return result
  }
  { print $1 "|" $2 "|" $3 "|" $4 "|" port_summary($5) }
  '
```

- [ ] **Step 2: Run test to verify it passes**

Run: `bash tests/docker_container_ls_test.sh`

Expected: PASS with exit code 0.

- [ ] **Step 3: Commit implementation**

```bash
git add docker_container_ls.sh tests/docker_container_ls_test.sh
git commit -m "feat: add summarized docker container listing"
```

### Task 3: Verificar sintaxis y salida real

**Files:**
- Modify: `docker_container_ls.sh`

- [ ] **Step 1: Check Bash syntax**

Run: `bash -n docker_container_ls.sh`

Expected: exit code 0.

- [ ] **Step 2: Execute against Docker when available**

Run: `./docker_container_ls.sh`

Expected: encabezado con `NAME|IMAGE|CREATED|STATUS|PORTS` y una fila por cada contenedor, o el error original de Docker si el daemon no está disponible.

- [ ] **Step 3: Commit any correction**

```bash
git add docker_container_ls.sh
git commit -m "fix: handle docker port output"
```
