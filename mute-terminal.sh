#!/bin/bash

#Controlo la existencia del archivo
if ! [ -e ~/.inputrc ]
then
    #Si el archivo no existe ==> lo creo.
    echo "set completion-ignore-case on" >> ~/.inputrc
    echo "set bell-style none" >> ~/.inputrc
else
    #Si el archivo existe ==> compruebo que no contenga las lineas y las agrego.
    linea_case=$(cat ~/.inputrc | grep "set completion-ignore-case on")
    linea_bell=$(cat ~/.inputrc | grep "set bell-style none")

    #echo "linea_case = ${linea_case}"
    #echo "linea_bell = ${linea_bell}"

    if [[ ${linea_case} != "set completion-ignore-case on" ]]
    then
        #echo "NO se encuentra la linea: set completion-ignore-case on"
        echo "set completion-ignore-case on" >> ~/.inputrc
    fi

    if [[ ${linea_bell} != "set bell-style none" ]]
    then
        #echo "NO se encuentra la linea: set bell-style none"
        echo "set bell-style none" >> ~/.inputrc
    fi
fi

if ! [ -e ~/.xprofile ]
then
    #Si el archivo no existe ==> lo creo.
    echo "xset -b" >> ~/.xprofile
else
    #Si el archivo existe ==> compruebo que no contenga la linea y la agrego.
    linea_xset=$(cat ~/.xprofile | grep "xset -b")

    #echo "linea_xset = ${linea_xset}"

    if [[ ${linea_xset} != "xset -b" ]]
    then
        #echo "NO se encuentra la linea: xset -b"
        echo "xset -b" >> ~/.xprofile
    fi
fi

echo "Mutea3"
echo "Dews!"
