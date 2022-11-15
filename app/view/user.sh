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
# Global Variables (created, updated): user_input
#
# File Loads:
# - view/lang/en.sh: Contains all text output by framework - English
#
##############################
. ./view/lang/en.sh

fwvu_greet_user() {
    fwvu_output "${fwvl_greetings}" true
}
##############################
#
# Purpose: Greets user, asks if any defaults should not be installed.
# Visibility: Framework - Public
# Uses: fwvu_ask
# Used By: fwcm_set_default_removes
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
fwvu_get_default_removes() {
    
    local msg="\n${defaults_prompt}\n"
    
    for i in ${!fwvl_default_apps[@]}; do
        local msg+="$(($i+1)). ${fwvl_default_apps[$i]}\n"
    done

    local msg+="${fwvl_quit_option}\n${fwvl_default_tool_prompt}"
    fwvu_output "${msg}" true true
}

##############################
#
# Purpose: Notifies user of invalid input, prompt for retry
# Visibility: Framework - Public
# Uses: fwvu_ask
# Used By: fwcv_validate_user_input
#
# Arguments: None
# Global Variables (created, updated): None
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
# Uses: fwvu_ask
# Used By: fwcv_check_quit
#
# Arguments: None
# Global Variables (created, updated): None
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
# Uses: fwvu_ask
# Used By: fwcv_check_quit
#
# Arguments: None
# Global Variables (created, updated): None
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
# Uses: None
# Used By: fwcv_validate_user_input
#
# Arguments: None
# Global Variables (created, updated): None
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
# Uses: None
# Used By: fwvu_verify_quit
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
fwvu_exit() {
    fwvu_output "${fwvl_goodbye}" true
    exit 0
}

##############################
#
# Purpose: Prompts user for input
# Visibility: Framework - Private
# Uses: None
# Used By: fwvu_get_default_removes, fwvu_retry_prompt, fwvu_verify_quit, 
# fwvu_error_exit, fwvu_exit
#
# Arguments: 
#  $msg (str) - text to ouput
#  $nl (bool) - set to true to output newline after msg
#  $prompt (bool) - set to true to prompt user for input 
# Global Variables (created, updated): None
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
# Arguments: None
#  $msg (str) - text to ouput
#  $nl (bool) - set to true to output newline after msg
# Global Variables (created, updated): None
# Return: void
#
##############################
fwvu_msg() {
    local msg=$1
    local nl=$2

    if [ "$nl" = true ]; then
        echo -e "${msg}"
    else
        echo -n -e "${msg}"
    fi
}

##############################
#
# Purpose: Prompt user for input
# Visibility: Framework - Private
# Uses: None
# Used By: fwvu_output
#
# Arguments: None
#  $prompt (bool) - set to true to prompt user for input 
# Global Variables (created, updated): user_input
# Return: void
#
##############################
fwvu_prompt() {
    unset user_input
    read user_input
}
