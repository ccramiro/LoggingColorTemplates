#!/bin/bash

# This scripts is meant to override mvn command in MacOS
# in order to replace output with proper format and color
# To override mvn command, following command should
# be added to $HOME/.bash_profile,
# being $PATH_TO_SCRIPT the path where this bash script is located
# alias mvn="$PATH_TO_SCRIPT"
# Example:
# alias mvn="/Users/ccramiro/scripts/MavenLoggingColorTemplate.sh"
# Don't forget to give execution permissions to this script:
# chmod +x MavenLoggingColorTemplate.sh

# Color and formar constants
export BOLD=`tput bold`
export UNDERLINE_ON=`tput smul`
export UNDERLINE_OFF=`tput rmul`
export TEXT_RED=`tput setaf 1`
export TEXT_GREEN=`tput setaf 2`
export TEXT_YELLOW=`tput setaf 3`
export TEXT_CYAN=`tput setaf 6`
export RESET_FORMATTING=`tput sgr0`

# Filtering maven output using sed
mvn $@ | sed -e "s/\[INFO\]/${BOLD}${TEXT_CYAN}\[INFO\]${RESET_FORMATTING}/g" \
          -e "s/BUILD SUCCESS/${BOLD}${TEXT_GREEN}BUILD SUCCESS${RESET_FORMATTING}/g" \
          -e "s/\[WARNING\]/${BOLD}${TEXT_YELLOW}\[WARNING\]${RESET_FORMATTING}/g" \
          -e "s/BUILD FAILURE/${BOLD}${TEXT_RED}BUILD FAILURE${RESET_FORMATTING}/g" \
          -e "s/FAILURE!/${BOLD}${TEXT_RED}FAILURE!${RESET_FORMATTING}/g" \
          -e "s/ERROR!/${BOLD}${TEXT_RED}ERROR!${RESET_FORMATTING}/g" \
          -e "s/\[ERROR\]/${BOLD}${TEXT_RED}\[ERROR\]${RESET_FORMATTING}/g" \
          -e "s/T E S T S/${BOLD}${TEXT_YELLOW}T E S T S${RESET_FORMATTING}/g" \
          -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${UNDERLINE_ON}${BOLD}${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${BOLD}${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${BOLD}${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${BOLD}${TEXT_YELLOW}\4${RESET_FORMATTING}/g"
 
# Restoring format
echo -ne ${RESET_FORMATTING}
