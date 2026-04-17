#!/usr/bin/env bash
#
# Install narikiri as a skill in both Claude Code and Codex CLI.
#
# Both clients use the same SKILL.md format (YAML frontmatter +
# references/), so we just symlink this repo into each client's
# skills directory.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_link() {
  local label="$1"
  local skills_dir="$2"
  local link="${skills_dir}/narikiri"

  mkdir -p "${skills_dir}"

  if [ -L "${link}" ]; then
    rm "${link}"
  elif [ -e "${link}" ]; then
    echo "Error: ${link} exists and is not a symlink." >&2
    echo "Refusing to overwrite. Remove it manually and re-run." >&2
    exit 1
  fi

  ln -s "${REPO_ROOT}" "${link}"
  echo "[${label}] ${link} -> ${REPO_ROOT}"
}

install_link "claude" "${HOME}/.claude/skills"
install_link "codex " "${HOME}/.codex/skills"

echo
echo "Done. Open a new session in either Claude Code or Codex and try:"
echo '  把这段改成体制内汇报风："项目做完了，效果还行，但有几个坑。"'
