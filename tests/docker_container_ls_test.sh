#!/usr/bin/env bash

set -euo pipefail

repo_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
mock_dir=$(mktemp -d)

if ! command -v column >/dev/null; then
  printf '%s\n' 'column is required for this test' >&2
  exit 1
fi

cleanup() {
  rm -rf "$mock_dir"
}
trap cleanup EXIT

printf '%s\n' \
  '#!/usr/bin/env bash' \
  'set -euo pipefail' \
  'if [[ "$1 $2 $3" != "container ls -a" ]]; then' \
  '  printf "unexpected docker arguments: %s\\n" "$*" >&2' \
  '  exit 1' \
  'fi' \
  'printf "%s\\n" "web|nginx:alpine|2 hours ago|Up 2 hours|0.0.0.0:8000->8080/tcp, 80/tcp"' \
  'printf "%s\\n" "api|example/api:latest|3 days ago|Exited (0) 1 day ago|8080/tcp, 9000/tcp"' \
  'printf "%s\\n" "worker|example/worker:latest|5 days ago|Created|"' \
  'printf "%s\\n" "proxy|nginx:stable|1 hour ago|Up 1 hour|0.0.0.0:8001->443/tcp, [::]:8001->443/tcp, 80/tcp"' \
  > "$mock_dir/docker"
chmod +x "$mock_dir/docker"

actual=$(PATH="$mock_dir:$PATH" "$repo_dir/docker_container_ls.sh")
expected=$(printf '%s\n' \
  'NAME|IMAGE|CREATED|STATUS|PORTS' \
  'web|nginx:alpine|2 hours ago|Up 2 hours|8000->8080, X->80' \
  'api|example/api:latest|3 days ago|Exited (0) 1 day ago|X->8080, X->9000' \
  'worker|example/worker:latest|5 days ago|Created|X' \
  'proxy|nginx:stable|1 hour ago|Up 1 hour|8001->443, X->80' |
  column -t -s '|')

if [[ "$actual" != "$expected" ]]; then
  printf 'unexpected output:\n%s\n' "$actual" >&2
  printf 'expected output:\n%s\n' "$expected" >&2
  exit 1
fi
