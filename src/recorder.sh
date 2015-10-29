#!/bin/bash
#################################################################
#                       Dolphin detector                        #
#                      versione 2.0 - 2015			#
#################################################################
#----------------------------------------------------------------

logdir="/home/mmo/.log/DolphinDetector"
datadir="/data"
psax=`ps ax`
jack_istance=`echo "$psax"|grep "jackd "`
recorder_istance=`echo "$psax"|grep "recorder.sh"|wc -l`
freq=`echo $jack_istance|egrep -o '\-r+[0-9]+'|cut -c 3-`
if test "$recorder_istance" -gt 1
then
  # ne basta uno
  echo "Recorder.sh già in esecuzione"
  exit 1
elif test -z "$jack_istance"
then
  zenity --no-wrap --error --text "Impossibile registrare\n\nErrore generato da: recorder.sh\nTipo di errore: jack non in esecuzione"
  exit 1
elif test -z "$freq"
then
  zenity --no-wrap --error --text "Impossibile registrare\n\nErrore generato da: recorder.sh\nTipo di errore: impossibile determinare la frequenza"
  exit 1
else
   date >> $logdir/recorder.log
   echo "Avvio recorder in corso..." >> $logdir/recorder.log
   export TERM=linux
   while test 1
   do
      dirname=`date +"%Y-%m-%d"`
      if ! test -d $datadir/"$dirname"
      then
         mkdir $datadir/"$dirname"
      fi
      dt=`date +"%Y%m%d_%H.%M.%S"`
      filename=$datadir"/"$dirname"/"$dt"_log.wav"
      echo $filename >> $logdir/recorder.filelist
      echo "Inizio registrazione $filename" >> $logdir/recorder.log
      /usr/bin/ecasound -f:16,1,$freq -i jack,system,1 -t:300.0 -o $filename 2>> $logdir/recorder.err
   done
fi
