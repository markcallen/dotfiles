#!/bin/bash

# nvm_cleanup.sh
# This script automatically removes inactive Node.js versions installed via NVM.
# It checks for Node.js versions that haven't been accessed or modified in the specified number of days
# and uninstalls them using NVM.
#
# Usage:
#   1. Make the script executable: chmod +x nvm_cleanup.sh
#   2. Run the script: ./nvm_cleanup.sh [--days NUMBER] [--dry-run] [--help]
#
# Options:
#   --days NUMBER    Number of days of inactivity before a version is considered for removal
#                    (default: 90 days)
#   --dry-run        Preview what would be removed without actually removing anything
#   --help           Show this help message
#
# Note: The script requires NVM to be installed and properly configured.
#       It will automatically source the NVM script if found in the default location.

show_help() {
  echo "Usage:"
  echo "  ./nvm_cleanup.sh [--days NUMBER] [--dry-run] [--help]"
  echo
  echo "Options:"
  echo "  --days NUMBER    Number of days of inactivity before a version is considered for removal"
  echo "                   (default: 90 days)"
  echo "  --dry-run        Preview what would be removed without actually removing anything"
  echo "  --help           Show this help message"
  echo
  echo "Note: The script requires NVM to be installed and properly configured."
  echo "      It will automatically source the NVM script if found in the default location."
  exit 0
}

TARGET_DIR="$HOME/.nvm/versions/node"
# Default value for days
DAYS=90
DRY_RUN=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --days)
      if ! [[ "$2" =~ ^[0-9]+$ ]]; then
        echo "Error: --days must be a positive number"
        exit 1
      fi
      DAYS="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --help)
      show_help
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help to see available options"
      exit 1
      ;;
  esac
done

NVM_DIR="$HOME/.nvm"  # Path to the NVM script

# Check if the NVM script file exists and source it
if [ -d "$NVM_DIR" ]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
  echo "NVM script not found, exiting."
  exit 1
fi

# Get current active Node.js version
CURRENT_VERSION=$(nvm current)
echo "Current active Node.js version: $CURRENT_VERSION"

# Print disk usage of NVM directory
echo "Current NVM disk usage:"
du -sh "$NVM_DIR"
echo

echo "Checking subdirectories of $TARGET_DIR for inactivity over $DAYS days..."

# Initialize counters
TOTAL_REMOVED=0
TOTAL_SIZE=0

find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
  dir_name=$(basename "$subdir")
  
  # Skip current version
  if [ "$dir_name" = "$CURRENT_VERSION" ]; then
    echo "Skipping current version: $dir_name"
    continue
  fi
  
  # Check if any file in the subdirectory was accessed or modified in the last specified days
  if ! find "$subdir" -type f -newermt "$DAYS days ago" | grep -q .; then
    if [ "$DRY_RUN" = true ]; then
      echo "Would remove inactive nvm: $dir_name"
    else
      echo "Removing inactive nvm: $dir_name"
      # Get size before removal
      size=$(du -sh "$subdir" | cut -f1)
      nvm uninstall "$dir_name"
      if [ $? -eq 0 ]; then
        TOTAL_REMOVED=$((TOTAL_REMOVED + 1))
        echo "Removed: $dir_name (size: $size)"
      else
        echo "Failed to remove: $dir_name"
      fi
    fi
  fi
done

# Print final disk usage after cleanup
echo
echo "Final NVM disk usage:"
du -sh "$NVM_DIR"

# Print summary
if [ "$DRY_RUN" = true ]; then
  echo
  echo "Dry run complete. No versions were actually removed."
else
  echo
  echo "Cleanup complete. Removed $TOTAL_REMOVED inactive Node.js versions."
fi
