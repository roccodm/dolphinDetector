#!/bin/bash

LOCKFILE=/tmp/update.${ACTION}.lock
if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`
then
   sleep 1s #skip
else
   trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
   echo $$ > ${LOCKFILE}
   sleep 20s
   if test -e /media/mmo/TOSHIBA\ EXT/dolphinDetector/update.sh
   then
       sh  /media/mmo/TOSHIBA\ EXT/dolphinDetector/update.sh &> /tmp/update_report.log
   else
       echo "Script non trovato" >> /tmp/udev.log
   fi
   rm -f ${LOCKFILE}
fi

