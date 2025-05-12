#!/bin/bash

# Path to .terraformrc
TERRAFORMRC="$HOME/.terraformrc"

# Extract the plugin_cache_dir value from the file
TARGET_DIR=$(grep '^plugin_cache_dir' "$TERRAFORMRC" | awk -F= '{gsub(/[ \t"]/, "", $2); print $2}')

# Expand $HOME in the path (if still present)
CACHE_DIR="${TARGET_DIR/\$HOME/$HOME}"

# Find and process all subdirectories
find "$CACHE_DIR" -type d -print0 | while IFS= read -r -d '' dir; do
  # Skip the root cache dir itself
  [ "$dir" = "$CACHE_DIR" ] && continue

  # Check if any files in the directory were accessed within the last 30 days
  if find "$dir" -type f -atime -30 | grep -q .; then
    # Recent file found; skip
    continue
  fi

  # Check again if the directory still exists before deletion
  if [ -d "$dir" ]; then
    echo "Deleting: $dir"
    rm -rf "$dir"
  fi
done
