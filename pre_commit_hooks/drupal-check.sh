#!/bin/bash

# Bash PHP Codesniffer Hook
# This script fails if the PHP Codesniffer output has the word "ERROR" in it.
# Does not support failing on WARNING AND ERROR at the same time.
#
# Exit 0 if no errors found
# Exit 1 if errors were found
#
# Requires
# - php
#
# Arguments
# - None

# Echo Colors
msg_color_magenta='\033[1;35m'
msg_color_yellow='\033[0;33m'
msg_color_none='\033[0m' # No Color

# Loop through the list of paths to run drupal-check against
echo -en "${msg_color_yellow}Begin PHP Codesniffer ...${msg_color_none} \n"
dc_local_exec="drupal-check.phar"
dc_command="php $dc_local_exec"

# Check vendor/bin/phpunit
dc_usr_bin_command="/usr/local/bin/drupal-check"
dc_global_command="drupal-check"
if [ -f "$dc_usr_bin_command" ]; then
	dc_command=$dc_usr_bin_command
else
    if hash drupal-check 2>/dev/null; then
        dc_command=$dc_global_command
    else
        if [ -f "$dc_local_exec" ]; then
            dc_command=$dc_command
        else
            echo "No valid PHP Codesniffer executable found! Please have one available as either $dc_usr_bin_command, $dc_global_command or $dc_local_exec"
            exit 1
        fi
    fi
fi

dc_files_to_check="${@:2}"
dc_args=$1
dc_command="$dc_command $dc_args $dc_files_to_check"

echo "Running command $dc_command"
command_result=`eval $dc_command`
if [[ $command_result =~ ERROR ]]
then
    echo -en "${msg_color_magenta}Errors detected by Drupal Check ... ${msg_color_none} \n"
    echo "$command_result"
    exit 1
fi

exit 0
