#!/bin/bash
# Da inserire in /etc/udev/rules.d/80-rocco.rules
#
# ACTION=="add", SUBSYSTEM=="usb", RUN+="/home/mmo/dolphinDetector/trap_udev.sh" 
# ACTION=="remove", SUBSYSTEM=="usb", RUN+="/home/mmo/dolphinDetector/trap_udev.sh" 


data=`date`
echo data >> /tmp/udev.log

# la dir /tmp/livess viene creata a processo di avvio eseguito
# in assenza di essa il trapping viene escluso
if test -d /tmp/livess
then
   echo "-------------------------------" > /tmp/udev.log
   env >> /tmp/udev.log
   date >> /tmp/udev.log
   whoami >> /tmp/udev.log

   if test -z "$ID_VENDOR_ENC"
   then
      ID_VENDOR_ENC="x"
   fi

   ishdd="`echo $ID_MODEL_FROM_DATABASE | grep 'External Disk USB'`"
   if test -n "$ishdd"
   then
      if [ $ACTION == "add" ]
      then
         LOCKFILE=/tmp/udevtrap.${ACTION}.lock
         if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`
         then
             sleep 1s #skip
         else
             trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
             echo $$ > ${LOCKFILE}
             nohup /home/mmo/dolphinDetector/update.sh &
             rm -f ${LOCKFILE}
         fi
      fi
   fi


   if test "RME" == "$ID_VENDOR_ENC"
   then
      if [ $ACTION == "add" ]
      then
         LOCKFILE=/tmp/udevtrap.${ACTION}.lock
         if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`
         then
             sleep 1s #skip
         else
             trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
             echo $$ > ${LOCKFILE}
             sudo DISPLAY=:0.0 -u mmo /home/mmo/dolphinDetector/ripristino_light.sh 
             zenity --no-wrap --display=:0.0 --info --text "Aggiunta automaticamente scheda audio e ripristinato sistema\nSe il problema risulta frequente chiedere assistenza" &
             rm -f ${LOCKFILE}
         fi
      else
         LOCKFILE=/tmp/udevtrap.${ACTION}.lock
         if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`
         then
             sleep 1s #skip
         else
             trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
             echo $$ > ${LOCKFILE}
             zenity --no-wrap --display=:0.0 --error --text "Scheda audio babyface disconnessa\nRicontrollare la connessione o sostituire la scheda\n" &
             rm -f ${LOCKFILE}
         fi
      fi
   fi
fi
