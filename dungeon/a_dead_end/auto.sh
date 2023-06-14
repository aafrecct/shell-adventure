#!/bin/bash

if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
    second_floor_name="segundo_piso"
    left_flame_file="llama_izquierda"
    right_flame_file="llama_derecha"
else
    second_floor_name="second_floor"
    left_flame_file="left_flame"
    right_flame_file="right_flame"
fi

check_flame() {
    while ! $(cmp --silent $left_flame_file $right_flame_file); do
        sleep 1
    done  
    
    if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
        echo "El suelo empieza a descencer formando una escalera a un piso inferior."
    else
        echo "The floor begins to lower creating creating a staircase to a lower floor"
    fi
 
    mkdir $second_floor_name
}

unalias cp
check_flame &
