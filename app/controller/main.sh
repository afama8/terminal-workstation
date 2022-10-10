#!/bin/bash

##############################
#
# Project: Terminal Workstation
# Author: Al Fama (afama8 - GitHub)
# License: GNU General Public License v3.0
# Repository: git@github.com:afama8/terminal-workstation.git
#
# File: controller/main.sh
# Purpose: Provide access to all application workflows
# Visibility: Framework - Public
# Global Variables (created, updated): None
#
# File Loads:
# - controller/view.sh: Manage workflows interacting directly with the user.
#
##############################
. ./controller/view.sh


##############################
#
# Purpose: Initial workflow kickoff
# Visibility: Framework - Public
# Calls: h_set_default_removes
# Used By: station_install.sh
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
h_main() {
    h_set_default_removes
}

##############################
#
# Purpose: Initial workflow kickoff, define default tools not to be installed
# Visibility: Framework - Public
# Calls: u_get_default_removes, h_validate_user_choices
# Used By: h_main
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
h_set_default_removes() {
    # Ask user about default apps
    u_get_default_removes
    h_validate_user_input ${#default_apps[@]}
}
