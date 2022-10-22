#!/bin/bash

##############################
#
# Project: Terminal Workstation
# Author: Al Fama (afama8 - GitHub)
# License: GNU General Public License v3.0
# Repository: git@github.com:afama8/terminal-workstation.git
#
# File: controller/view.sh
# Purpose: Manage workflows interacting directly with the user. 
# Visibility: Framework - Private
# Global Variables (created, updated): choices
#
# File Loads:
# - user.sh: Provides framework all functionality for interacting with the user
#
##############################
. ./view/user.sh


##############################
#
# Purpose: Define default tools not to be installed
# Visibility: Framework - Public
# Uses: fwvu_get_default_removes, fwcv_validate_user_choices
# Used By: fwcm_main
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
fwcv_set_default_removes() {
    # Ask user about default apps
    fwvu_get_default_removes
    fwcv_validate_user_input ${#fwvl_default_apps[@]}
}

##############################
#
# Purpose: Initial function to validate all user input 
# Visibility: Framework - Public
# Uses: fwcv_check_quit, fwcv_validate_choices
# Used By: fwcm_set_default_removes, fwvu_retry_prompt,
# fwvu_error_exit
#
# Arguments: validate_type (str) , [option_count (int)] 
# Global Variables (created, updated): choices
# Return: void
#
##############################
fwcv_validate_user_input() {
    local option_count="$1"
    # remove magic number
    local retry_count=2
    
    while [ $retry_count != 0 ]; do
        # switch begin

        # case: $validate_type == 'options'
        # Parse and validate user input
	IFS=', ' read -r -a choices <<< "$user_input"
        fwcv_check_quit "${choices[@]}"
        # Iteration accepts choices
	fwcv_validate_choices $option_count
	# end

	# switch end

        if [[ 1 -eq $? ]]; then
	    # Invalid option selected
	    (( retry_count-- ))
	    fwvu_retry_prompt
	    continue
	fi
	break
    done
    
    if [ $retry_count == 0 ]; then
        fwvu_error_exit
    fi
}

##############################
#
# Purpose: Validate user input for options workflow
# Visibility: Framework - Private
# Uses: None
# Used By: fwcv_validate_user_input
#
# Arguments: None
# Global Variables (created, updated): None
# Return: int 0 = valid, 1 = not valid
#
##############################
fwcv_validate_choices() {
    local option_count="$1"
    
    # Validate option is valid int
    for val in ${choices[@]}; do
        if [[ $option_count -lt $val ]] || 
	   [[ 0 == ${val} ]] || 
	   [[ $((val)) != ${val} ]]; 
	then
	    return 1
    	fi
    done
}

##############################
#
# Purpose: Determines if user wants to quit the app - quit workflow
# Visibility: Framework - Private
# Calls: fwvu_verify_quit
# Used By: fwcv_validate_user_input
# 
# Arguments: user_input (mixed)
# Global Variables (created, updated): None
# Return: void
#
##############################
fwcv_check_quit() {
    local options=("$@")
    # Check if argument recived is an array, if not convert to array
    if [[ " ${options[*]^^} " =~ "Q" ]]; then
	fwcv_verify_quit
    fi
}

##############################
#
# Purpose: Confirm user would like to quit
# Visibility: Framework - Private
# Uses: fwvu_verify_quit, fwvu_exit
# Used By: fwcv_check_quit
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
fwcv_verify_quit() {
    fwvu_verify_quit
    if [[ " ${user_input^^} " =~ "Y" ]]; then
        fwvu_exit
    fi
}
