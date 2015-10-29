#!/bin/bash

    export TERM=linux
    export HOME=/home/mmo
    export DISPLAY=:0.0
    killall ams.real
    killall ecasound
    for i in 1 2 3 4 5 6 7 8
    do
      killall jackd
    done
    sleep 30s # attendo sia ready

    soundcards=`/usr/bin/aplay -l`
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
        samplerate=48000
    fi

    cat /proc/asound/cards > /tmp/debug.rok
    /usr/bin/aplay -l &> /tmp/debug.rok
    env >> /tmp/debug.rok
    nohup /usr/bin/jackd -dalsa -dhw:1 -r$samplerate -p512 -n2 &>> /home/mmo/.log/DolphinDetector/jackd.log &

    sleep 3s
    /home/mmo/dolphinDetector/filtro_audio.sh

