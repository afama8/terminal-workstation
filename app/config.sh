#!/bin/bash

# ############################
#
# Project: Terminal Workstation
# Author: Al Fama (afama8 - GitHub)
# License: GNU General Public License v3.0
# Repository: git@github.com:afama8/terminal-workstation.git
#
# File: config.sh
# Purpose: Application Configuration File
# Visibility: Global
# Global Variables: fwc_try_count
#
# File Loads: None
#
##############################

##############################
#
# Purpose: The number of chances a user has to submit a valid response
# Used By: fwcv_validate_user_input
#
##############################
fwc_try_count=3

##############################
#
# Purpose: Language directory path
# Used By: fwcv_load_lang
#
##############################
fwc_lang_dir="./view/lang"

##############################
#
# Purpose: Default language file
# Used By: fwcv_load_lang
#
##############################
fwc_default_lang_file="en_US.sh"

