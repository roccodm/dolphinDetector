#!/bin/bash
###############################################
# Dolphin detector 2.0
# (c) Rocco De Marco 2013-2015
#
###############################################
# Routine di configurazione delle schede audio
###############################################
# Versione 0.3

APLAY="/usr/bin/aplay"

if ! test -e $APLAY
then
    zenity --display=:0.0 --error --no-wrap --text "Errore in configurazione schede audio\naplay non trovato"
    while test 1 ; do sleep 1 ; done #loop infinito
fi

soundcards=`aplay -l`

if test -n "`echo $soundcards|grep -i babyface`"
then
    #babyface
    samplerate=96000
elif test -n "`echo $soundcards|grep -i lexicon`"
then
    #lexicon
    samplerate=48000
elif test -n "`echo $soundcards|grep -i ugm`"
then
    #ugm
    samplerate=48000
else
    zenity --display=:0.0 --error --no-wrap --text "Errore in configurazione schede audio\nNessuna scheda audio supportata è stata trovata\nVerificare le connessioni usb o reinizializzare la babyface (cfr guida)"
    while test 1 ; do sleep 1 ; done #loop infinito
fi

nohup /usr/bin/jackd -dalsa -dhw:1 -r$samplerate -p512 -n2 2> /home/mmo/.log/DolphinDetector/jackd.log &
