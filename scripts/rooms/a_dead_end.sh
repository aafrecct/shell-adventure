#!/bin/bash

if [ $SHELL_ADVENTURE_LANG -eq "es"]; then
    second_floor_name="segundo-piso"
else
    second_floor_name="second-floor"
fi

check_flame() {
    while ! $(cmp --silent left_flame right_flame); do
        sleep 1
    done  
    
    if [ $SHELL_ADVENTURE_LANG -eq "es"]; then
        echo "El suelo empieza a descencer formando una escalera a un piso inferior."
    else
        echo "The floor begins to lower creating creating a staircase to a lower floor"
    fi
 
    mkdir $second_floor_name
}

if [ -e $second_floor_name ]; then
    check_flame &
fi
