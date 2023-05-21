#!/bin/bash

if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
    second_floor_name="segundo_piso"
else
    second_floor_name="second_floor"
fi

check_flame() {
    while ! $(cmp --silent left_flame right_flame); do
        sleep 1
    done  
    
    if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
        echo "El suelo empieza a descencer formando una escalera a un piso inferior."
    else
        echo "The floor begins to lower creating creating a staircase to a lower floor"
    fi
 
    mkdir $second_floor_name
}

check_flame &
