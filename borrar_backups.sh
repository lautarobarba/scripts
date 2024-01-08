#!/usr/bin/env bash

#========== CONFIG ========================================================
DIR_BACKUPS="./backups"     	# Directorio de backups
CANT_MAX=2                	# Cantidad de backups que se desea mantener
LOG_DIR="./borrar_backups.log"  # Archivo donde se guardarán los logs
#======== END CONFIG ======================================================


CANT_ARCHIVOS=$(( $(ls ${DIR_BACKUPS} -l | wc -l) - 1 ))
SCRIPT_PATH=$(realpath $0)
WORKDIR=$(dirname ${SCRIPT_PATH})
DIR=$(pwd)

echo [$(date)] "========== Comenzando script de Limpieza de Backups ==========" >>$LOG_DIR
echo [$(date)] "Existen ${CANT_ARCHIVOS} archivos. Cantidad máxima permitida: ${CANT_MAX}." >>${LOG_DIR}


if [ ${CANT_ARCHIVOS} -gt ${CANT_MAX} ]
then
    echo [$(date)] "Se borraran los siguientes archivos: " >>${LOG_DIR}
    ls ${DIR_BACKUPS} -l | sort | head -n $(( ${CANT_ARCHIVOS} - ${CANT_MAX} )) | awk '{print $9}' | xargs printf -- "[$(date)]    -> ${DIR_BACKUPS}/%s\n" >>${LOG_DIR}
    ls ${DIR_BACKUPS} -l | sort | head -n $(( ${CANT_ARCHIVOS} - ${CANT_MAX} )) | awk '{print $9}' | xargs printf -- "${DIR_BACKUPS}/%s " | xargs rm
    if [ $? -ne 0 ]; then 
	echo [$(date)] "STATUS: ERROR" >>$LOG_DIR
	echo [$(date)] "STATUS: LIMPIEZA INCOMPLETA" >>$LOG_DIR
	echo ------------------------------------ >>$LOG_DIR
    	exit 1
    else
	echo [$(date)] "STATUS: OK" >>$LOG_DIR
    fi
else
    echo [$(date)] "No es necesario borrar nada..." >>${LOG_DIR}
    echo [$(date)] "STATUS: OK" >>$LOG_DIR
fi

# Vuelvo al directorio actual
cd ${DIR}
echo [$(date)] "STATUS: LIMPIEZA FINALIZADA CORRECTAMENTE" >>$LOG_DIR
echo ------------------------------------ >>$LOG_DIR
exit 0
