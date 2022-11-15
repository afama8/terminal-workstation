#!/bin/bash

##############################
#
# Project: Terminal Workstation
# Author: Al Fama (afama8 - GitHub)
# License: GNU General Public License v3.0
# Repository: git@github.com:afama8/terminal-workstation.git
#
# File: view/lang/en.sh
# Purpose: Contains all text output by framework - English
# Visibility: Global
# Global Variables (created, updated): greetings, default_apps, 
# default_tool_prompt, quit_option, goodbye, invalid_option_prompt
# verify_quit, error_quit
#
# File Loads: None
#
##############################


##############################
#
# Purpose: Initial output, greet, start default tools
# Used By: fwvu_get_default_removes
#
##############################
fwvl_greetings="
#################################
# Terminal Workstation Install #
#################################

Hello, thank you for choosing our Terminal Workstation, for your basic terminal 
needs.

No changes will be made to your system during this phase. Feel free to exit 
the installion at any point."

##############################
#
# Purpose: List default tools
# Used By: fwvu_get_default_removes
#
##############################
defaults_prompt="By default the following tools, and their required packages, will be installed:"

##############################
#
# Purpose: List default tools
# Used By: fwvu_get_default_removes
#
##############################
fwvl_default_apps=("tmux (screen multiplxer) - provides ability to split screen" 
	      "Vim (text editor)" 
	      "Lynx (web browser) - will also install PowerTools repo")


##############################
#
# Purpose: Default tool prompt
# Used By: fwvu_get_default_removes
#
##############################
fwvl_default_tool_prompt="If you do NOT want to install any of these tools, please list them by number
seperated by a comma:"

##############################
#
# Purpose: Add quit option
# Used By: fwvu_get_default_removes
#
##############################
fwvl_quit_option="Q. Quit
"

##############################
#
# Purpose: User quit message
# Used By: fwvu_exit
#
##############################
fwvl_goodbye="Sorry to see you go. No changes have been made to your system."

##############################
#
# Purpose: Invalid option prompt
# Used By: fwvu_retry_prompt
#
##############################
fwvl_invalid_option_prompt="Invalid option entered. Please retry: "

##############################
#
# Purpose: Verify quit prompt
# Used By: fwvu_verify_quit_prompt
#
##############################
fwvl_verify_quit="Are you sure you want to quit? (y/n): "

##############################
#
# Purpose: Polite retry, seen when user chooses not to quit at confirmation. 
# Used By: fwvu_no_quit
#
##############################
fwvl_no_quit="Please retry: "

##############################
#
# Purpose: Unexpected error, exit
# Used By: fwvu_error_exit
#
##############################
fwvl_error_quit="It seems there is an error. The application must exit now."
