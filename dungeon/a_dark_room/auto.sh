
if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
    next_room_name="la_habitacion_de_la_espada"
    expected_file_name="hoguera"
    alias encender=touch
else
    next_room_name="the_sword_room"
    expected_file_name="fire"
    alias light=touch
fi

check_fire() {
    while ! [ -f $expected_file_name ]; do
        sleep 1
    done  
    
    if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
        echo "La habitación esta caliente. La puerta se abre."
    else
        echo "The room is warm. The door opens."
    fi
 
    chmod 755 $next_room_name
}

unalias who
unalias whoami
check_fire &
