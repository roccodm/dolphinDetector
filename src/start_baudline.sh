#!/bin/bash

psax=`ps -ax`
if test -z "`echo $psax | grep -i baudline_jack`"
then 
   echo "Avvio baudline"
   /home/mmo/baudline/baudline_jack -jack -channels 1 -inconnect system:capture_1 -record -samplerate 8000 -session mmo -palette ~/baudline/palettes/rocco3 2>  /home/mmo/.log/DolphinDetector/baudline.log &
else
   zenity --info --text "Baudline realtime risulta già in esecuzione"
fi
