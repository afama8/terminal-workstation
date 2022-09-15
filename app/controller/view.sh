#!/bin/bash

h_set_default_removes() {
    # Ask user about default apps
    u_get_default_removes
    h_validate_user_input_choices ${#default_apps[@]} "${removes[@]}"
}

h_validate_user_input_choices() {
    local option_count="$1"
    shift
    local options=("$@")

    # Parse and validate user input
    IFS=', ' read -r -a removes <<< "$remove"
    # Start while loop
    # Iteration accepts choices
    h_validate_choices ${#default_apps[@]} "${removes[@]}" 
    if [[ 1 -eq $? ]]; then
	# Invalid option selected
	exit 0
    fi
}

h_validate_choices() {
    local choice_count="$1"
    shift
    local options=("$@")
    
    h_check_quit "${options[@]}"
    
    # Validate option is valid int
    for val in ${options[@]}; do
        if [[ $choice_count -lt $val ]] || 
	   [[ 0 == ${val} ]] || 
	   [[ $((val)) != ${val} ]]; 
	then
	    return 1
    	fi
    done
}

h_check_quit() {
    local options=("$@")
    
    if [[ " ${options[*]^^} " =~ "Q" ]]; then
        echo "${goodbye}"
        exit 0
    fi
}
