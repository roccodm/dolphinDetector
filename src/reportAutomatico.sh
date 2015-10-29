#!/bin/bash

data=`zenity  --title "Generazione report" --text "Selezionare data inizio report" --calendar --date-format "%d/%m/%Y"`

days=`zenity --entry --title "Generazione report" --entry-text 1 --text "Durata report (giorni)" 2 3 4 5 6 7 14 21 28 31`

immagini=`zenity --entry --title "Generazione report" --entry-text "SI" --text "Aggiungere immagini (incrementa dimensione)" SI NO`



if test -n "$data" 
then
   mkdir /tmp/report_mmo/
   cd /tmp/report_mmo/

   if [ $immagini == "NO" ]
   then
      wget --no-check-certificate -nd -nc -k "http://localhost/mmo/default/week_report?start_date=$data&days=$days" 
   else
      wget --no-check-certificate -p -nd -nc -k "http://localhost/mmo/default/week_report?start_date=$data&days=$days" 
   fi
   timestamp=`date +"%Y%m%d_%H%M%S"`
   data=`echo $data|sed s/"\/"//g`
   filename="report_$data.durata_$days.generato_$timestamp"
   tar cfvz /data/report/$filename.tar.gz *
   rm -rf /tmp/report_mmo/
   zenity --no-wrap --info --title "Generazione report" --text "La generazione del report è avvenuta"

else

   zenity --no-wrap --error --title "Generazione report" --text "La data di inizio report è indispensabile"

fi

nautilus /data/report/ &
