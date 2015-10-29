#!/bin/bash

if `zenity --no-wrap --question --text "Confermi ripristino sistema PAM?\n(da usare solo in caso di malfunzionamento)"`
then
    killall ams.real
    for i in 1 2 3 4 5 6 7 8
    do
      killall jackd
    done
    sleep 1s #da diminuire!!!
    /home/mmo/dolphinDetector/schede.sh
    sleep 3s
    /home/mmo/dolphinDetector/filtro_audio.sh
    zenity --info --text "Sistema audio ripristinato"
fi

