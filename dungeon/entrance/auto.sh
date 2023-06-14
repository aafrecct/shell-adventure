echo 

if [[ "$SHELL_ADVENTURE_LANG" == "es" ]]; then
    echo "Has entrado en una mazmorra oscura, es dificil ver que hay en esta 
sala. Para leer las descripciones de cada sala, puedes escribir \`cat desc\`"
else
    echo "You enter a dark dungeon, it's hard to make out the stuff in this
room. To read a description for every room you enter type \`cat desc\`"
fi

echo

unalias ls
unalias cat
sleep 1
