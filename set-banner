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
#          set-banner          #
#                              #
################################

if [[ $# -eq 1 ]]
then
    cat ~/scripts/banner > /tmp/prebanner
    cat $(pwd)/$1 >> /tmp/prebanner
    cat /tmp/prebanner > $(pwd)/$1
    rm /tmp/prebanner
else
    echo Ejecutar como: $ set-banner nombre_archivo
fi
