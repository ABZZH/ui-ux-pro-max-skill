#!/bin/bash
set -euo pipefail

# Only run in remote cloud sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

mkdir -p ~/.claude/skills

# Copy all repo-bundled skills to global skills directory
for skill_dir in "$CLAUDE_PROJECT_DIR/.agents/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  rm -rf ~/.claude/skills/"$skill_name"
  cp -r "$skill_dir" ~/.claude/skills/"$skill_name"
done

# Install nano-banana (not bundled in repo)
if [ ! -d ~/.claude/skills/nano-banana ]; then
  git clone --depth=1 https://github.com/kkoppenhaver/cc-nano-banana ~/.claude/skills/nano-banana
fi
