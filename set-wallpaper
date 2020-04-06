#!/bin/bash
#
################################
#      _                       #
#  ___| |_ _ __ __ _ ______ _  #
# / __| __| '__/ _` |_  / _` | #
# \__ \ |_| | | (_| |/ / (_| | #
# |___/\__|_|  \__,_/___\__,_| #
#                              #
#------------------------------#
#        set-wallpaper         #
#                              #
################################

if [[ $# -eq 1 ]]
then
    echo $(pwd)/$1 > ~/.config/wallpaper
    feh --bg-scale $(cat ~/.config/wallpaper)
    wal -n -a 90 -i $(cat ~/.config/wallpaper)
else
    echo Ejecutar como: $ set-wallpaper nombre_archivo
fi
