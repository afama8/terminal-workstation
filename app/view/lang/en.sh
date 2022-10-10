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
# User Function: 
# Variables: greetings, default_apps, greetings2
#
##############################
greetings="
#################################
# Terminal Workstation Install #
#################################

Hello, thank you for choosing our Terminal Workstation, for your basic terminal 
needs.

No changes will be made to your system during this phase. Feel free to exit 
the installion at any point. 

By default the following tools, and their required packages, will be installed:"

default_apps=("tmux (screen multiplxer) - provides ability to split screen" 
	      "Vim (text editor)" 
	      "Lynx (web browser) - will also install PowerTools repo")

greetings2="Q. Quit

If you do NOT want to install any of these tools, please list them by number
seperated by a comma:"

##############################
# End User Function: 
##############################

goodbye="Sorry to see you go. No changes have been made to your system."

invalid_option_prompt="Invalid option entered. Please retry: "

verify_quit="Are you sure you want to quit? (y/n): "

error_quit="It seems there is an error. The application must exit now."
