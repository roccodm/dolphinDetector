#!/bin/bash


# verifico che il disco sia montato correttamente

#if test -z "`mount |grep -i TOSH`"
#then
#   # primo tentativo, provo a montarlo per cavoli miei
#   pmount /dev/sdc1 /media/mmo/TOSHIBA_EXT
#fi

impianto=`cat /home/mmo/dolphinDetector/impianto.txt`
echo $impianto

if test -z "`mount |grep -i '/media/mmo/TOSHIBA EXT'`"
then
   devices=`lsusb|grep -i tosh`

   zenity --error --display=:0.0 --title "Errore in backup" --no-wrap --text \
"Errore: il disco esterno per i backup non risulta disponibile\n \
verificare che sia collegato su una porta usb (azzurra) e che sia \n \
montato (cliccare su Risorse -> Toshiba Ext)\n\n \
Se il problema persiste chiedere assistenza specificando i seguenti dati:\n \
Problema: Impossibile rilevare il disco usb per i backup\n\n\
LSUSB: $devices \n\n \
Questo messaggio, in mancanza del disco per i backup, appare ogni ora"

else
   if ! test -d "/media/mmo/TOSHIBA EXT/$impianto"
   then
      mkdir "/media/mmo/TOSHIBA EXT/$impianto"
   fi
   if ! test -d "/media/mmo/TOSHIBA EXT/$impianto/audiofiles"
   then
      mkdir "/media/mmo/TOSHIBA EXT/$impianto/audiofiles"
   fi
   if ! test -d "/media/mmo/TOSHIBA EXT/$impianto/datafiles"
   then
      mkdir "/media/mmo/TOSHIBA EXT/$impianto/datafiles"
   fi
   if ! test -d "/media/TOSHIBA EXT/$impianto/logfiles"
   then
      mkdir "/media/mmo/TOSHIBA EXT/$impianto/logfiles"
   fi
   if ! test -d "/media/mmo/TOSHIBA EXT/$impianto/pictures"
   then
      mkdir "/media/mmo/TOSHIBA EXT/$impianto/pictures"
   fi
   if ! test -e "/media/mmo/TOSHIBA EXT/$impianto/trasfered_files"
   then
      touch "/media/mmo/TOSHIBA EXT/$impianto/transfered_files"
   fi
   # Backup dei file di log
   rsync -h -v -r -P -t /home/mmo/.log/ "/media/mmo/TOSHIBA EXT/$impianto/logfiles"
   rsync -h -v -r -P -t /home/mmo/Immagini/ "/media/mmo/TOSHIBA EXT/$impianto/pictures"
   rsync -h -v -r -P -t /data/report/ "/media/mmo/TOSHIBA EXT/$impianto/report"
   rsync -h -v -r -P -t /home/www-data/web2py/ "/media/mmo/TOSHIBA EXT/$impianto/web2py"
   /home/mmo/dolphinDetector/backup.py "/media/mmo/TOSHIBA EXT/$impianto/transfered_files"
   data=`date +"%d/%m/%Y %H:%M:%S"`
   echo "L'ultimo backup è stato concluso: $data " > /home/mmo/.log/DolphinDetector/backup.timestamp
fi




