#!/usr/bin/env bash
################################################################################
#
# Bash Psalm
#
# This script fails if Psalm output has the word "ERROR" in it.
#
# Exit 0 if no errors found
# Exit 1 if errors were found
#
# Requires
# - php
#
# Arguments
# See: https://psalm.dev/docs/running_psalm/command_line_usage/
#
################################################################################

# Plugin title
title="Psalm"

# Possible command names of this tool
local_command="psalm.phar"
vendor_command="vendor/bin/psalm"
global_command="psalm"

# Print a welcome and locate the exec for this tool
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DIR/helpers/colors.sh
source $DIR/helpers/formatters.sh
source $DIR/helpers/welcome.sh
source $DIR/helpers/locate.sh

command_files_to_check="${@:2}"
command_args=$1
command_to_run="${exec_command} ${command_args} ${command_files_to_check}"

echo -e "${bldwht}Running command ${txtgrn} ${exec_command} ${command_args} ${txtrst}"
hr
command_result=`eval $command_to_run`
if [[ $command_result =~ ERROR ]]
then
    hr
    echo -en "${bldmag}Errors detected by ${title}... ${txtrst} \n"
    hr
    echo "$command_result"
    exit 1
fi

exit 0
