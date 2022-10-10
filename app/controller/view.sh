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
# Global Variables (created, updated):
#
# File Loads:
# - user.sh: Provides framework all functionality for interacting with the user
#
##############################
. ./view/user.sh


##############################
#
# Purpose: Initial function to validate all user input 
# Visibility: Framework - Public
# Calls: h_check_quit
# Used By: h_set_default_removes, h_validate_choices, u_retry_prompt,
# u_error_exit
#
# Arguments: validate_type (str) , [option_count (int)] 
# Global Variables (created, updated): varies
# Return: void
#
##############################
h_validate_user_input() {
    local option_count="$1"
    # remove magic number
    local retry_count=2

    while [ $retry_count != 0 ]; do
        # switch begin

        # case: $validate_type == 'options'
        # Parse and validate user input
	IFS=', ' read -r -a choices <<< "$user_input"
        h_check_quit "${choices[@]}"
        # Iteration accepts choices
	h_validate_choices $option_count
	# end

	# switch end

        if [[ 1 -eq $? ]]; then
	    # Invalid option selected
	    (( retry_count-- ))
	    u_retry_prompt
	    continue
	fi
	break
    done
    
    if [ $retry_count == 0 ]; then
        u_error_exit
    fi
}

##############################
#
# Purpose: Validate user input for options workflow
# Visibility: Framework - Private
# Calls: None
# Used By: h_validate_user_input
#
# Arguments: None
# Global Variables (created, updated): None
# Return: int 0 = valid, 1 = not valid
#
##############################
h_validate_choices() {
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
# Calls: h_verify_quit
# Used By: h_validate_user_input
# 
# Arguments: user_input (mixed)
# Global Variables (created, updated): None
# Return: void
#
##############################
h_check_quit() {
    local options=("$@")
    # Check if argument recived is an array, if not convert to array
    if [[ " ${options[*]^^} " =~ "Q" ]]; then
	h_verify_quit
    fi
}

##############################
#
# Purpose: Confirm user would like to quit
# Visibility: Framework - Private
# Calls: u_verify_quit, u_exit
# Used By: h_check_quit
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
h_verify_quit() {
    u_verify_quit
    if [[ " ${user_input^^} " =~ "Y" ]]; then
        u_exit
    fi
}
