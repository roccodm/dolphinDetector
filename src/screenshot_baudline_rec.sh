#!/bin/bash

data=`date +"%Y%m%d_%H%M%S"`
filename="baudline_rec_$data"

window_id=`wmctrl -l |grep baudline |grep view |cut -f1 -d" "`

if test -z $window_id
then
   zenity --error --no-wrap --text "Impossibile effettuare lo screenshot.\nLa finestra non risulta aperta"
else
   import -rec -window $window_id /home/mmo/Immagini/screenshoot/$filename
   zenity --info --text "Screenshot effettuato e salvato in Immagini/screenshot"
fi
