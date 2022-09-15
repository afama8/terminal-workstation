#!/bin/bash

# Initial Greeting - default apps
u_get_default_removes() {
    echo "${greetings}"
    
    for i in ${!default_apps[@]}; do
        echo "$(($i+1)). ${default_apps[$i]}"
    done

    echo "${greetings2}"
    u_ask
}

u_retry_prompt() {
    echo -n "${invalid_option_prompt}"
    u_ask
}

u_verify_quit() {
    echo -n "${verify_quit}"
    u_ask
}

u_error_exit() {
    echo "${error_quit}"
    exit 1
}

u_ask() {
    unset user_input
    read user_input
}
