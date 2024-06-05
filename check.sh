#!/usr/bin/env bash

# Lista de dependencias
DEPENDENCIAS_APT=(
	"git" "dialog" "stow" 
	"xmonad" "libghc-xmonad-contrib-dev" "xterm" "suckless-tools"
);
DEPENDENCIAS_SNAP=()
ERRORES=0

# Control de dependencias
for DEP in ${DEPENDENCIAS_APT[*]}
do
	INSTALADO=$(apt list --installed ${DEP} 2>/dev/null | grep instal | cut -d '/' -f 1)
	if [ ! ${INSTALADO} ] 
	then
		ERRORES+=1
		echo "Falta instalar > ${DEP}. Instalar con: $ sudo apt install ${DEP}"
	fi
done

for DEP in ${DEPENDENCIAS_SNAP[*]}
do
	INSTALADO=$(which ${DEP})
	if [ ! ${INSTALADO} ] 
	then
		ERRORES+=1
		echo "Falta instalar > ${DEP}. Instalar con: $ sudo snap install ${DEP}"
	fi
done

if [ ${ERRORES} != 0 ]
then
	exit ${ERRORES}
fi

echo "Continuo con la instalación"