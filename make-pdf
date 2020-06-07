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
#          pdf-maker           #
################################

fotos=$(ls)
contador=01
for f in ${fotos}
do
    mv $f img$(printf "%03d" $contador).jpg
    contador=$((contador+1))
done

fotos=$(ls)
for f in ${fotos}
do
    convert -resize 50% $f $f
done

convert *.jpg archivo.pdf
