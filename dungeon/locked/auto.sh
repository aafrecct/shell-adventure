#!/bin/bash

if [[ $SHELL_ADVENTURE_LANG == "es" ]]; then
  rm $SHELL_ADVENTURE_ROOT/visited/cerrado  
  cd entrada
else
  rm $SHELL_ADVENTURE_ROOT/visited/locked  
  cd entrance
fi
