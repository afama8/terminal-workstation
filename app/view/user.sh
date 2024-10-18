#!/bin/bash

##############################
#
# Project: Terminal Workstation
# Author: Al Fama (afama8 - GitHub)
# License: GNU General Public License v3.0
# Repository: git@github.com:afama8/terminal-workstation.git
#
# File: view/user.sh
# Purpose: Provides framework all functionality for interacting with the user. 
# Visibility: Framework - Public
# Global Variables: fwvl_greetings, defaults_prompt, fwvl_default_apps, 
# fwvl_quit_option, fwvl_default_tool_prompt, fwvl_invalid_option_prompt, 
# fwvl_verify_quit, fwvl_error_quit, fwvl_goodbye, 
#
# File Loads: None
#
##############################


##############################
#
# Purpose: Greets user
# Visibility: Framework - Public
# Uses: fwvu_output
# Used By: fwcv_set_default_removes
#
# Arguments: None
# Global Variables: fwvl_greetings
# Return: void
#
##############################
fwvu_greet_user() {
    fwvu_output "${fwvl_greetings}" true
}

##############################
#
# Purpose: Present default tools, ask user if all should be installed.
# Visibility: Framework - Public
# Uses: fwvu_output
# Used By: fwcv_set_default_removes
#
# Arguments: None
# Global Variables: defaults_prompt, fwvl_default_apps, fwvl_quit_option,
# fwvl_default_tool_prompt
# Return: void
#
##############################
fwvu_get_default_removes() {
    local msg="\n${defaults_prompt}\n"
    
    for i in ${!fwvl_default_apps[@]}; do
        msg+="$(($i+1)). ${fwvl_default_apps[$i]}\n"
    done

    msg+="${fwvl_quit_option}\n${fwvl_default_tool_prompt}"
    fwvu_output "${msg}" true true
}

##############################
#
# Purpose: Notifies user of invalid input, prompt for retry
# Visibility: Framework - Public
# Uses: fwvu_output
# Used By: fwcv_validate_user_input
#
# Arguments: validation_type (str)
# Global Variables: fwvl_invalid_option_prompt
# Return: void
#
##############################
fwvu_retry_prompt() {
    local validate_type="$1"

    case $validate_type in
    options)
        fwvu_output "${fwvl_invalid_option_prompt}" false true
        ;;

    esac
}

##############################
#
# Purpose: Prompts user for quit confirmation
# Visibility: Framework - Public
# Uses: fwvu_output
# Used By: fwcv_verify_quit
#
# Arguments: None
# Global Variables: fwvl_verify_quit
# Return: void
#
##############################
fwvu_verify_quit() {
    fwvu_output "${fwvl_verify_quit}" false true
}

##############################
#
# Purpose: Prompts after user does not quit
# Visibility: Framework - Public
# Uses: fwvu_get_default_removes
# Used By: fwcv_verify_quit
#
# Arguments: process (str)
# Global Variables: None
# Return: void
#
##############################
fwvu_no_quit() {
    local process="$1"

    case $process in
    defaults)
        fwvu_get_default_removes
        ;;

    esac
}

##############################
#
# Purpose: Notify user of an internal error, exit app
# Visibility: Framework - Public
# Uses: fwvu_output
# Used By: fwcv_validate_user_input
#
# Arguments: None
# Global Variables: fwvl_error_quit
# Return: void
#
##############################
fwvu_error_exit() {
    fwvu_output "${fwvl_error_quit}" true
    exit 1
}

##############################
#
# Purpose: User or application exits, purposefully
# Visibility: Framework - Public
# Uses: fwcv_output
# Used By: fwvu_verify_quit
#
# Arguments: None
# Global Variables: fwvl_goodbye
# Return: void
#
##############################
fwvu_exit() {
    fwvu_output "${fwvl_goodbye}" true
    exit 0
}

##############################
#
# Purpose: Manages output to user
# Visibility: Framework - Private
# Uses: fwvu_msg, fwvu_prompt
# Used By: fwvu_greet_user, fwvu_get_default_removes, fwvu_retry_prompt, 
# fwvu_verify_quit, fwvu_error_exit, fwvu_exit
#
# Arguments: msg (str), nl (bool), prompt (bool)
# Global Variables: None
# Return: void
#
##############################
fwvu_output() {
    local msg=$1
    local nl=$2
    local prompt=$3

    fwvu_msg "${msg}" $nl
    if [ "$prompt" = true ]; then
        fwvu_prompt
    fi
}

##############################
#
# Purpose: Output message to user
# Visibility: Framework - Private
# Uses: None
# Used By: fwvu_output
#
# Arguments: msg (str), nl (bool)
# Global Variables: None
# Return: void
#
##############################
fwvu_msg() {
    local msg=$1
    local nl=$2

    if [ "$nl" = true ]; then
        echo -e "${msg}"
        return 0
    fi
    
    echo -n -e "${msg}"
}

##############################
#
# Purpose: Prompt user for input
# Visibility: Framework - Private
# Uses: None
# Used By: fwvu_output
#
# Arguments: None
# Global Variables: user_input
# Return: void
#
##############################
fwvu_prompt() {
    unset user_input
    read user_input
}
