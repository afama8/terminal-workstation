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
# Global Variables: choices, fwc_try_count, user_input
#
# File Loads:
# - user.sh: Provides framework all functionality for interacting with the user
#
##############################
. ./view/user.sh

##############################
#
# Purpose: Load language file based on system setting.
# Visibility: Framework - Public
# Uses: 
# Used By: fwcm_main
#
# Arguments: None
# Global Variables: None
# Return: void
#
##############################
fwcv_load_lang() {
    local lang=$LANG
    local lang_file="${fwc_lang_dir}/${fwc_default_lang_file}"

    if test -f "${fwc_lang_dir}/${lang%.*}.sh"; then
        lang_file=${fwc_lang_dir}/${lang%.*}.sh
    fi
    . $lang_file
}

##############################
#
# Purpose: Define default tools not to be installed
# Visibility: Framework - Public
# Uses: fwvu_greet_user, fwvu_get_default_removes, fwcv_validate_user_input
# Used By: fwcm_main
#
# Arguments: None
# Global Variables: None
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
# Uses: fwcv_check_quit, fwcv_validation_controller, fwvu_retry_prompt, 
# fwvu_error_exit
# Used By: fwcv_set_default_removes
# 
# Arguments: process (str), validate_type (str), [option_count (int)]
# Global Variables: choices, fwc_try_count, user_input
# Return: void
#
##############################
fwcv_validate_user_input() {
    local process="$1"
    local validate_type="$2"
    # localize config var
    local try_count=$fwc_try_count
    local valid=1

    while [[ $try_count != 0 ]]; do
        fwcv_check_quit $process
        
        # Skip on 1st iteration
        if [[ $try_count != $fwc_try_count ]]; then
            fwvu_retry_prompt $validate_type
        fi
        
        fwcv_validation_controller $@ 
        valid=$?

        unset $user_input
        if [[ 0 -eq $valid ]]; then
            return 0
        fi
        # Invalid option selected
        (( try_count-- ))
    done
    # If we are here there is an error
    fwvu_error_exit
}

##############################
#
# Purpose: Validation controller for user input
# Visibility: Framework - Private
# Uses: fwcv_validate_choices
# Used By: fwcv_validate_user_input
# 
# Arguments: process (str), validate_type (str), [option_count (int)]
# Global Variables: user_input, choices
# Return: int 0 = valid, 1 = not valid
#
##############################
fwcv_validation_controller() {
    local process="$1"
    local validate_type="$2"
    local valid=1

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

    return $valid
}

##############################
#
# Purpose: Validate user input for options workflow
# Visibility: Framework - Private
# Uses: None
# Used By: fwcv_validate_user_input
#
# Arguments: option_count (int)
# Global Variables: choices
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
# Calls: fwcv_verify_quit
# Used By: fwcv_validate_user_input
# 
# Arguments: process (str)
# Global Variables: user_input
# Return: void
#
##############################
fwcv_check_quit() {
    local process="$1"
    
    if [[ " ${user_input^^} " =~ "Q" ]]; then
        fwcv_verify_quit $process
    fi
}

##############################
#
# Purpose: Confirm user would like to quit
# Visibility: Framework - Private
# Uses: fwvu_verify_quit, fwvu_exit, fwvu_no_quit
# Used By: fwcv_check_quit
#
# Arguments: process (str)
# Global Variables: user_input
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
