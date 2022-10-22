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
    echo "${fwvl_greetings}"
    
    for i in ${!fwvl_default_apps[@]}; do
        echo "$(($i+1)). ${fwvl_default_apps[$i]}"
    done

    echo "${fwvl_quit_option}"
    echo "${fwvl_default_tool_prompt}"
    fwvu_ask
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
    echo -n "${fwvl_invalid_option_prompt}"
    fwvu_ask
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
    echo -n "${fwvl_verify_quit}"
    fwvu_ask
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
    echo "${fwvl_error_quit}"
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
    echo "${fwvl_goodbye}"
    exit 0
}

##############################
#
# Purpose: Manage input from user
# Visibility: Framework - Private
# Uses: None
# Used By: fwvu_get_default_removes, fwvu_retry_prompt, fwvu_verify_quit, 
# fwvu_error_exit, fwvu_exit
#
# Arguments: None
# Global Variables (created, updated): user_input
# Return: void
#
##############################
fwvu_ask() {
    unset user_input
    read user_input
}
