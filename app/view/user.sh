#!/bin/bash

# Initial Greeting - default apps
u_get_default_removes() {
    echo "${greetings}"
    
    for i in ${!default_apps[@]}; do
        echo "$(($i+1)). ${default_apps[$i]}"
    done

    echo "${greetings2}"
    read remove
}

u_retry_prompt() {
    unset retry
    echo "${invalid_option_prompt}"
    read retry
}
