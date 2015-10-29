#!/bin/bash
#################################################################
#                       Dolphin detector                        #
#                      versione 2.0 - 2015			#
#################################################################
#----------------------------------------------------------------

(sleep 1 && wmctrl -a Startup -b add,above)&
(
echo "10" ; sleep 5
echo "# Avvio di jackd" ; /home/mmo/dolphinDetector/schede.sh
echo "20" ; sleep 1
echo "# Avvio del recorder" ; nohup /home/mmo/dolphinDetector/recorder.sh &
echo "50" ; sleep 1
echo "# Avvio dello spettrogramma" ; /home/mmo/baudline/baudline_jack -jack -channels 1 -inconnect system:capture_1 -record -samplerate 8000 -session mmo -palette ~/baudline/palettes/rocco3 2>  .log/DolphinDetector/baudline.log &
echo "70" ; sleep 1
echo "# Creazione connessioni jack" ; /home/mmo/dolphinDetector/filtro_audio.sh
echo "85" ; sleep 1
echo "# Demone screenshot" ; nohup /home/mmo/dolphinDetector/remote_screenshot.sh &
echo "100" ; sleep 1
) |
zenity --progress \
  --title="Startup" \
  --text="Dolphin Detector 2.0\n(c) Rocco De Marco 2015" \
  --percentage=0 \
  --auto-close


