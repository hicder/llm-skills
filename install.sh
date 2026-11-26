#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"
TARGET_DIRS=(~/.claude/skills ~/.agents/skills ~/.gemini/config/skills)

for target_dir in "${TARGET_DIRS[@]}"; do
  if [ -L "$target_dir" ]; then
    rm "$target_dir"
  fi
  mkdir -p "$target_dir"
done

for skill_dir in "$SKILLS_DIR"/*/; do
  [ -d "$skill_dir" ] || continue
  skill_path="${skill_dir%/}"
  skill_name="$(basename "$skill_path")"

  for target_dir in "${TARGET_DIRS[@]}"; do
    dest="$target_dir/$skill_name"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "Skipping $dest: already exists"
      continue
    fi
    ln -sfn "$skill_path" "$dest"
  done
done
