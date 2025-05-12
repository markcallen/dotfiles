#!/bin/bash

# Usage: ./brew_health.sh [options]
# Options:
#   --force     Run maintenance regardless of last run time
#   --cleanup   Remove any stale lock file before running
#   --dry-run   Show what would be done without making changes
#   --status    Show when the script was last run
#
# This script performs Homebrew maintenance tasks including:
# - Updating Homebrew
# - Upgrading outdated packages
# - Cleaning up unused packages
# - Upgrading outdated casks (applications)
#
# The script will only run if it hasn't been run in the last 7 days,
# unless the --force option is used.

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Set this if not defined in your shell environment
HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

# Lock file to prevent concurrent runs
LOCKFILE="/tmp/$(basename "$0").lock"

# Timestamp storage file
LAST_RUN_FILE="$HOME/.last_script_run"

# Current time in seconds since epoch
NOW=$(date +%s)

# How many seconds in 7 days
SEVEN_DAYS=$((7 * 24 * 60 * 60))

# Function to display help message
show_help() {
    echo "Usage: ./brew_health.sh [options]"
    echo ""
    echo "This script performs Homebrew maintenance tasks including:"
    echo "  - Updating Homebrew"
    echo "  - Upgrading outdated packages"
    echo "  - Cleaning up unused packages"
    echo "  - Upgrading outdated casks (applications)"
    echo ""
    echo "Options:"
    echo "  --help     Show this help message"
    echo "  --force    Run maintenance regardless of last run time"
    echo "  --cleanup  Remove any stale lock file before running"
    echo "  --dry-run  Show what would be done without making changes"
    echo "  --status   Show when the script was last run"
    echo ""
    echo "The script will only run if it hasn't been run in the last 7 days,"
    echo "unless the --force option is used."
    exit 0
}

# Parse arguments
FORCE_RUN=false
CLEANUP_LOCK=false
DRY_RUN=false
SHOW_STATUS=false

while [[ "$1" != "" ]]; do
    case $1 in
        --help ) show_help ;;
        --force ) FORCE_RUN=true ;;
        --cleanup ) CLEANUP_LOCK=true ;;
        --dry-run ) DRY_RUN=true ;;
        --status ) SHOW_STATUS=true ;;
        * ) echo -e "${RED}Unknown option: $1${NC}"; show_help ;;
    esac
    shift
done

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${RED}Error: Homebrew is not installed.${NC}"
    echo "Please install Homebrew first: https://brew.sh/"
    exit 1
fi

# Function to show status
show_status() {
    if [ -f "$LAST_RUN_FILE" ]; then
        LAST_RUN=$(cat "$LAST_RUN_FILE")
        TIME_DIFF=$((NOW - LAST_RUN))
        DAYS_AGO=$((TIME_DIFF / (24 * 60 * 60)))
        
        if [ "$DAYS_AGO" -eq 0 ]; then
            echo -e "${GREEN}The script was run today.${NC}"
        elif [ "$DAYS_AGO" -eq 1 ]; then
            echo -e "${GREEN}The script was run 1 day ago.${NC}"
        else
            echo -e "${YELLOW}The script was run $DAYS_AGO days ago.${NC}"
        fi
    else
        echo -e "${YELLOW}The script has never been run.${NC}"
    fi
    exit 0
}

# If status is requested, show it and exit
if $SHOW_STATUS; then
    show_status
fi

# If cleanup is requested, remove the lock file before proceeding
if $CLEANUP_LOCK; then
    echo -e "${YELLOW}Cleaning up stale lock file (if exists)...${NC}"
    rm -f "$LOCKFILE"
fi

# Function to run brew command with error handling
run_brew_command() {
    local cmd="$1"
    local description="$2"
    
    echo -e "${YELLOW}$description...${NC}"
    if $DRY_RUN; then
        echo "[DRY RUN] Would run: $cmd"
        return 0
    fi
    
    if ! $cmd; then
        echo -e "${RED}Error: Failed to $description${NC}"
        return 1
    fi
    return 0
}

# Function to update and clean Homebrew
run_brew_maintenance() {
    run_brew_command "$HOMEBREW_PREFIX/bin/brew update" "Updating Homebrew" || return 1
    run_brew_command "$HOMEBREW_PREFIX/bin/brew upgrade" "Upgrading outdated packages" || return 1
    run_brew_command "$HOMEBREW_PREFIX/bin/brew cleanup" "Cleaning up unused packages" || return 1
    run_brew_command "$HOMEBREW_PREFIX/bin/brew upgrade --cask" "Upgrading outdated casks (applications)" || return 1
    
    echo -e "${GREEN}Brew health check complete!${NC}"
    return 0
}

# Acquire lock
if [ -e "$LOCKFILE" ]; then
    echo -e "${RED}Script is already running. Exiting.${NC}"
    exit 1
else
    # Create lock file and ensure it's removed on exit
    touch "$LOCKFILE"
    trap 'rm -f "$LOCKFILE"' EXIT
fi

# Main logic
if $FORCE_RUN; then
    echo -e "${YELLOW}Forced run triggered. Running maintenance...${NC}"
    if run_brew_maintenance; then
        echo "$NOW" > "$LAST_RUN_FILE"
    else
        echo -e "${RED}Maintenance failed. Please check the errors above.${NC}"
        exit 1
    fi
else
    if [ -f "$LAST_RUN_FILE" ]; then
        LAST_RUN=$(cat "$LAST_RUN_FILE")
        TIME_DIFF=$((NOW - LAST_RUN))

        if [ "$TIME_DIFF" -ge "$SEVEN_DAYS" ]; then
            echo -e "${YELLOW}The script has NOT been run in the last 7 days. Running maintenance...${NC}"
            if run_brew_maintenance; then
                echo "$NOW" > "$LAST_RUN_FILE"
            else
                echo -e "${RED}Maintenance failed. Please check the errors above.${NC}"
                exit 1
            fi
        else
            echo -e "${GREEN}The script was run within the last 7 days. Skipping maintenance.${NC}"
        fi
    else
        echo -e "${YELLOW}The script has NEVER been run before. Running maintenance...${NC}"
        if run_brew_maintenance; then
            echo "$NOW" > "$LAST_RUN_FILE"
        else
            echo -e "${RED}Maintenance failed. Please check the errors above.${NC}"
            exit 1
        fi
    fi
fi

