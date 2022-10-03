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
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
u_retry_prompt() {
    echo -n "${invalid_option_prompt}"
    u_ask
}

##############################
#
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
u_verify_quit() {
    echo -n "${verify_quit}"
    u_ask
}

##############################
#
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
u_error_exit() {
    echo "${error_quit}"
    exit 1
}

##############################
#
# Purpose: of function
# Visibility: who should be using the function.
# Arguments: accepted and their expected type
# Return: created/update global variables
#
##############################
u_ask() {
    unset user_input
    read user_input
}
