#!/bin/bash

# ===============================================
# Yarn Cache Cleanup Script
# ===============================================
#
# This script helps manage the Yarn cache by:
# 1. Displaying current cache disk usage
# 2. Finding and cleaning up packages that haven't been accessed in 90+ days
#
# Usage:
#   ./yarn_cleanup.sh [--dry-run] [--days N]
#
# Options:
#   --dry-run    Preview what would be cleaned without actually deleting
#   --days N     Set number of days for unused packages (default: 90)
#
# The script will:
# - Show current disk space used by Yarn cache
# - List directories not accessed in the specified time period
# - Automatically clean cached packages that are old and unused
# - Show summary of cleaned packages and space saved
#
# Note: This script requires yarn to be installed and in your PATH
# ===============================================

# Default values
DRY_RUN=false
DAYS=90

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --days)
      DAYS="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Check if running as root
if [[ $EUID -eq 0 ]]; then
  echo "Error: This script should not be run as root"
  exit 1
fi

# Get the Yarn cache directory
YARN_CACHE_DIR=$(yarn cache dir)

# Make sure the directory exists
if [ ! -d "$YARN_CACHE_DIR" ]; then
  echo "Yarn cache directory not found: $YARN_CACHE_DIR"
  exit 1
fi

# Print disk usage of Yarn cache directory
echo "Current Yarn cache disk usage:"
du -sh "$YARN_CACHE_DIR"
echo

echo "Scanning Yarn cache directory: $YARN_CACHE_DIR"
echo "Directories not accessed in the last $DAYS days:"

# Initialize counters
TOTAL_CLEANED=0
TOTAL_ERRORS=0

# Loop through subdirectories
find "$YARN_CACHE_DIR" -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
  # Check if any file inside has been accessed in the last specified days
  recent_access=$(find "$dir" -type f -atime -$DAYS -print -quit)
  if [ -z "$recent_access" ]; then
    filename=$(basename $dir)
    echo $filename
    
    if [[ "$filename" =~ ^npm-(@?[^-]+(-[^-]+)*)-([0-9]+\.[0-9]+\.[0-9]+)- ]]; then
      name="${BASH_REMATCH[1]}"
      version="${BASH_REMATCH[3]}"
      
      if [ "$DRY_RUN" = true ]; then
        echo "[DRY RUN] Would clean: ${name}${version}"
      else
        if yarn cache clean "${name}${version}" && rm -rf "$dir"; then
          ((TOTAL_CLEANED++))
        else
          echo "Error cleaning ${name}${version}"
          ((TOTAL_ERRORS++))
        fi
      fi
    else
      echo "Filename doesn't match expected pattern"
    fi
  fi
done

# Print final disk usage after cleanup (only if not dry-run)
if [ "$DRY_RUN" = false ]; then
  echo
  echo "Final Yarn cache disk usage:"
  du -sh "$YARN_CACHE_DIR"
fi

# Print summary
echo
if [ "$DRY_RUN" = true ]; then
  echo "Dry run complete. No files were deleted."
else
  echo "Summary:"
  echo "- Total packages cleaned: $TOTAL_CLEANED"
  echo "- Total errors: $TOTAL_ERRORS"
fi