#!/bin/bash

if [ $SHELL_ADVENTURE_LANG -eq "es"]; then
    room_name="segundo_piso"
else
    room_name="second_floor"
fi

if [ "$(dirname "$PWD")" -ne $SHELL_ADVENTURE_ROOT]; then
    if [ $SHELL_ADVENTURE_LANG -eq "es"]; then
        echo "Las escaleras vuelven a subir, no hay forma de salir."
    else
        echo "The stairs go back up, there's no turning back now."
    fi
    cd $SHELL_ADVENTURE_ROOT/locked/$room_name
fi
