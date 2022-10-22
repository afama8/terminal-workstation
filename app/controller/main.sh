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
# Uses: fwcm_set_default_removes
# Used By: station_install.sh
#
# Arguments: None
# Global Variables (created, updated): None
# Return: void
#
##############################
fwcm_main() {
    fwcv_set_default_removes
}

