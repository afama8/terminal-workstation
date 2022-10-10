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
# - view/text.sh: Provides framework functionality for interacting with the user
#
##############################
. ./view/text.sh

##############################
#
# Purpose: Greets user, asks if any defaults should not be installed.
# Visibility: Framework - Public
# Calls: u_ask
# Used By: h_set_default_removes
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
u_get_default_removes() {
    echo "${greetings}"
    
    for i in ${!default_apps[@]}; do
        echo "$(($i+1)). ${default_apps[$i]}"
    done

    echo "${greetings2}"
    u_ask
}

##############################
#
# Purpose: Notifies user of invalid input, prompt for retry
# Visibility: Framework - Public
# Calls: u_ask
# Used By: h_validate_user_input
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
u_retry_prompt() {
    echo -n "${invalid_option_prompt}"
    u_ask
}

##############################
#
# Purpose: Prompts user for quit confirmation
# Visibility: Framework - Public
# Calls: u_ask
# Used By: h_check_quit
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
u_verify_quit() {
    echo -n "${verify_quit}"
    u_ask
}

##############################
#
# Purpose: Notify user of an internal error, exit app
# Visibility: Framework - Public
# Calls: None
# Used By: h_validate_user_input
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
u_error_exit() {
    echo "${error_quit}"
    exit 1
}

##############################
#
# Purpose: User or application exits, purposefully
# Visibility: Framework - Public
# Calls: None
# Used By: h_verify_quit
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
u_exit() {
    echo "${goodbye}"
    exit 0
}

##############################
#
# Purpose: Manage input from user
# Visibility: Framework - Private
# Calls: None
# Used By: u_get_default_removes, u_retry_prompt, u_verify_quit, u_error_exit
# u_exit
#
# Arguments: None
# Global Variables (created, updated): user_input
# Return: void
#
##############################
u_ask() {
    unset user_input
    read user_input
}
