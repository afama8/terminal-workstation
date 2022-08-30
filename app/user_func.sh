#!/bin/bash


u_set_default_removes() {
    echo "${greetings}"
    
    for i in ${!default_apps[@]}; do
        echo "$(($i+1)). ${default_apps[$i]}"
    done

    echo "${greetings2}"
    read not_install
}
