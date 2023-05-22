#!/bin/bash

if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
    room_name="segundo_piso"
else
    room_name="second_floor"
fi

if [[ "$(dirname "$PWD")" != "$SHELL_ADVENTURE_ROOT/locked" ]]; then
    if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
        echo "Las escaleras vuelven a subir, no hay forma de salir."
    else
        echo "The stairs go back up, there's no turning back now."
    fi
    cd $SHELL_ADVENTURE_ROOT/locked/$room_name
fi
