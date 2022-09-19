#!/usr/bin/env bash
#
################################
#      _                       #
#  ___| |_ _ __ __ _ ______ _  #
# / __| __| '__/ _` |_  / _` | #
# \__ \ |_| | | (_| |/ / (_| | #
# |___/\__|_|  \__,_/___\__,_| #
#                              #
#------------------------------#
#  BorrarBackUps - Programa    #
#                              #
################################



DIR_BACKUPS="./backups"     # Directorio donde se guardan los backups
CANT_MAX=2                  # Cantidad de backups que se desea mantener
LOG_DIR="./borrar_log.log"  # Archivo donde se guardarán los logs

echo "== Script =="

CANT_ARCHIVOS=$(( $(ls ${DIR_BACKUPS} -l | wc -l) - 1 ))
echo "Cantidad maxima permitida: ${CANT_MAX}. Hay ${CANT_ARCHIVOS} archivos." >> ${LOG_DIR}

echo "$(date) Revisando..." >> ${LOG_DIR}

if [ ${CANT_ARCHIVOS} -gt ${CANT_MAX} ]
then
    echo "Borrando archivos..."
    echo "$(date) Borrando archivos..." >> ${LOG_DIR}
    echo "Se borraran los siguientes archivos: "
    echo "$(date) Se borraran los siguientes archivos: " >> ${LOG_DIR}
    ls ${DIR_BACKUPS} -l | sort | head -n $(( ${CANT_ARCHIVOS} - ${CANT_MAX} )) | awk '{print $9}' | xargs printf -- "   -> ${DIR_BACKUPS}/%s \n"
    ls ${DIR_BACKUPS} -l | sort | head -n $(( ${CANT_ARCHIVOS} - ${CANT_MAX} )) | awk '{print $9}' | xargs printf -- "$(date)    -> ${DIR_BACKUPS}/%s \n" >> ${LOG_DIR}
    ls ${DIR_BACKUPS} -l | sort | head -n $(( ${CANT_ARCHIVOS} - ${CANT_MAX} )) | awk '{print $9}' | xargs printf -- "${DIR_BACKUPS}/%s " | xargs rm
else
    echo "No hace falta borrar nada."
    echo "$(date) No hace falta borrar nada." >> ${LOG_DIR}
fi
