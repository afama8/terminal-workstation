#!/bin/bash

##############################
#
# Project: Terminal Workstation
# Author: Al Fama (afama8 - GitHub)
# Repository: git@github.com:afama8/terminal-workstation.git
#
# Purpose: 
# Visibility: View
# Global Variables (referenced, created, updated):
#
##############################


##############################
#
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
h_set_default_removes() {
    # Ask user about default apps
    u_get_default_removes
    h_validate_user_choices ${#default_apps[@]}
}

##############################
#
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
h_validate_user_choices() {
    local option_count="$1"
    local retry_count=2

    while [ $retry_count != 0 ]; do
        # Parse and validate user input
	IFS=', ' read -r -a choices <<< "$user_input"
        # Start while loop
	# Iteration accepts choices
	h_validate_choices $option_count
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
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
h_validate_choices() {
    local option_count="$1"
    
    h_check_quit "${choices[@]}"
    
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
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
h_check_quit() {
    local options=("$@")
    
    if [[ " ${options[*]^^} " =~ "Q" ]]; then
	h_verify_quit
    fi
}

##############################
#
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
# Note: This function will overwrite $user_input, store value before calling.
h_verify_quit() {
    u_verify_quit
    if [[ " ${user_input^^} " =~ "Y" ]]; then
        echo "${goodbye}"
        exit 0
    fi
}
