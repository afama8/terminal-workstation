#!/bin/bash

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

goodbye="Sorry to see you go. No changes have been made to your system."

invalid_option_prompt="Invalid option entered. Please retry:"
