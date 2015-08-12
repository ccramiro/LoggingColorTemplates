#!/bin/bash

# This script is meant to override mvn command in Linux
# in order to replace output with proper format and color
# To override mvn command, following command should
# be added to $HOME/.bashrc,
# being $PATH_TO_SCRIPT the path where this bash script is located
# alias mvn="$PATH_TO_SCRIPT"
# Example:
# alias mvn="/home/ccramiro/scripts/MavenLoggingColorTemplate.sh"
# Don't forget to give execution permissions to this script:
# chmod +x MavenLoggingColorTemplate.sh

# Color and formar constants

export BOLD="$(printf '\033[1m')"
export TEXT_RED="$(printf '\033[31m')"
export TEXT_GREEN="$(printf '\033[32m')"
export TEXT_YELLOW="$(printf '\033[33m')"
export TEXT_CYAN="$(printf '\033[36m')"
export RESET_FORMATTING="$(printf '\033[0m')"

# Filtering maven output using sed
mvn $@ | sed -e "s/\[INFO\]/${BOLD}${TEXT_CYAN}\[INFO\]${RESET_FORMATTING}/g" \
          -e "s/BUILD SUCCESS/${BOLD}${TEXT_GREEN}BUILD SUCCESS${RESET_FORMATTING}/g" \
          -e "s/\[WARNING\]/${BOLD}${TEXT_YELLOW}\[WARNING\]${RESET_FORMATTING}/g" \
          -e "s/BUILD FAILURE/${BOLD}${TEXT_RED}BUILD FAILURE${RESET_FORMATTING}/g" \
          -e "s/FAILURE!/${BOLD}${TEXT_RED}FAILURE!${RESET_FORMATTING}/g" \
          -e "s/ERROR!/${BOLD}${TEXT_RED}ERROR!${RESET_FORMATTING}/g" \
          -e "s/\[ERROR\]/${BOLD}${TEXT_RED}\[ERROR\]${RESET_FORMATTING}/g" \
          -e "s/T E S T S/${BOLD}${TEXT_YELLOW}T E S T S${RESET_FORMATTING}/g" \
          -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${BOLD}${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${BOLD}${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${BOLD}${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${BOLD}${TEXT_YELLOW}\4${RESET_FORMATTING}/g"
 
# Restoring format
echo -ne ${RESET_FORMATTING}

