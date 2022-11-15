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
# Uses: fwvu_greet_user, fwvu_get_default_removes, fwcv_validate_user_input
# Used By: fwcm_main
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
fwcv_set_default_removes() {
    # Ask user about default apps
    fwvu_greet_user
    fwvu_get_default_removes
    fwcv_validate_user_input "defaults" "options" ${#fwvl_default_apps[@]}
}

##############################
#
# Purpose: Initial function to validate all user input 
# Visibility: Framework - Public
# Uses: fwcv_check_quit, fwcv_validate_choices
# Used By: fwcm_set_default_removes, fwvu_retry_prompt,
# fwvu_error_exit
#
# Arguments: validate_type (str), process (str) ,[option_count (int)]
# Global Variables: choices, fwc_retry_count, user_input (destroyed)
# Return: void
#
##############################
fwcv_validate_user_input() {
    local process="$1"
    local validate_type="$2"
    # localize config var
    local retry_count=$fwc_retry_count
    local valid=1

    while [[ $retry_count != 0 ]]; do
        # Check if user wants to quit
        fwcv_check_quit $process
        
        # Skip on 1st iteration
        if [[ $retry_count != $fwc_retry_count ]]; then
	    fwvu_retry_prompt $validate_type
        fi
        
        case $validate_type in
        options)
            local option_count="$3"
            # Parse and validate user input
	    IFS=', ' read -r -a choices <<< "$user_input"
            # Iteration accepts choices
	    fwcv_validate_choices $option_count
            valid=$?
            ;;

        esac

        if [[ 0 -eq $valid ]]; then
            echo $valid
            break
        fi
	# Invalid option selected
	(( retry_count-- ))

    done

    if [[ 0 == $retry_count && 1 -eq $valid ]]; then
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
    return 0
}

##############################
#
# Purpose: Determines if user wants to quit the app - quit workflow
# Visibility: Framework - Private
# Calls: fwvu_verify_quit
# Used By: fwcv_validate_user_input
# 
# Arguments: user_input (mixed)
# Global Variables  (created, updated): None
# Return: void
#
##############################
fwcv_check_quit() {
    local process="$1"
    # Check if argument recived is an array, if not convert to array
    if [[ " ${user_input^^} " =~ "Q" ]]; then
	fwcv_verify_quit $process
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
    local process="$1"
    
    fwvu_verify_quit

    if [[ " ${user_input^^} " =~ "Y" ]]; then
        fwvu_exit
    fi

    fwvu_no_quit $process
}
