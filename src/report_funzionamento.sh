#!/bin/bash
###############################################
# Dolphin detector 2.0
# (c) Rocco De Marco 2013-2015
#
###############################################
# Routine di configurazione delle schede audio
###############################################
# Versione 0.3



psax=`ps ax`
soundcards=`aplay -l`

cat<<eof

******************************************************************
*                   Dolphin Detector v. 2.0                      *
*                   (c) 2015 - Rocco De Marco                    *
******************************************************************

          Report sullo stato di funzionamento del sistema
          -----------------------------------------------

eof
date +"%d %m %Y, %H:%M"
echo ""
echo "1) Controllo presenza scheda audio"
echo "=================================="
echo ""


frase="Trovata una scheda audio correttamente funzionante:"


if test -n "`echo $soundcards|grep -i babyface`"
then
    #babyface
    scheda="RME Babyface"
    echo $frase
    echo $scheda
elif test -n "`echo $soundcards|grep -i lexicon`"
then
    #lexicon
    scheda="Lexicon alpha"
    echo $frase
    echo $scheda
elif test -n "`echo $soundcards|grep -i ugm`"
then
    #ugm
    scheda="ESI UGM96"
    echo $frase
    echo $scheda
else
cat << eof
ERRORE!
Non è stata trovata nessuna scheda audio utilizzabile come sorgente d'ingresso sul presente sistema.
Il problema può dipendere da:

1) Scheda audio non collegata
S) Verificare il che il cavo di collegamento sia connesso su una porta usb. 
   Provare a riavviare il sistema acustico 
   (Applicazioni -> dolphinDetector -> Strumenti di manutenzione -> riavvia)

2) Scheda audio babyface da rinizializzare
S) Metodo da utilizzare solo con la babyface.
   Se la scheda audio è correttamente collegata e si accendono dei led il problema
   potrebbe essere affrontato con un ripristino della scheda.
   Il ripristino va effettuato nel seguente modo:
   a) scollegare il cavo usb da dietro la schieda
   b) premere e tenere premuti i due pulsati (select) e (recall) presenti sulla scheda
   c) collegare il cavo usb (le due barre a led si accenderanno in progressione)
   d) lasciare i pulsanti (select) e (recall)
   e) riavviare il computer
   Eventualmente la procedura va ripetuta almeno 3 volte prima di provare con
   le seguenti soluzioni

3) Scheda audio non funzionante
S) Se la scheda dispone di led e non sono accessi, nonostante il cavo connesso, 
   può indicare un malfunzionamento hardware.
   provare:
   a) riavviare il sistema acustico 
   (Applicazioni -> dolphinDetector -> Strumenti di manutenzione -> riavvia)
   b) riavviare il computer
   c) sostituire la scheda con una di scorta e riavviare il computer

4) Sistema compromesso
S) Se si sono tentate le soluzioni precedenti senza esito, provare ad utilizzare
   il computer di scorta messo a disposizione. 
   Collegare tutti i dispositivi (monitor, tastiera, mouse, scheda audio, alimentazione)
   prima di accendere il computer.

5) Impossibilità di far funzionare nessun computer/scheda
S) In questa estrema possibilità, continuare con il monitoraggio acustico collegando le 
   cuffie direttamente alla gp receiver

eof

fi

echo ""
echo "2) Funzionamento del recorder"
echo "=================================="
echo ""

istanze=`echo $psax | grep recorder.sh`
n_istanze=`echo $istanze|wc -l`
if test $n_istanze -eq 1
then
    echo "Il recorder risulta in esecuzione in modo corretto"
    echo "l'ultimo file registrato risulta:"
    tail -n 1 /home/mmo/.log/DolphinDetector/recorder.filelist
elif test $n_istanze -eq 0
then
cat << eof
ERRORE!

Il recorder non risulta in funzione. Il problema può essere causato dall'assenza di una scheda audio
o da un malfunzionamento di sistema.

Provare a:
   a) riavviare il sistema acustico 
   (Applicazioni -> dolphinDetector -> Strumenti di manutenzione -> riavvia)
   b) riavviare il computer
   c) nel caso il problema persista, sostituire il computer
eof

else
cat << eof
ERRORE!

Il recorder risulta in funzione in più istanze. Potrebbe trattarsi di una anomalia software
Provare a:
   a) riavviare il sistema acustico 
   (Applicazioni -> dolphinDetector -> Strumenti di manutenzione -> riavvia)
   b) riavviare il computer
   c) nel caso il problema persista, sostituire il computer
eof

fi


echo ""
echo "3) Controllo stato backup"
echo "=================================="
echo ""

if test -z "`mount |grep -i '/media/mmo/TOSHIBA EXT'`"
then
   devices=`lsusb|grep -i tosh`
cat<< eof

ERRORE!

Non risulta collegato o montato il disco usb TOSHIBA per effettuare i backup.

Verificare che il disco sia collegato ad una delle porte usb di colore blu
poste sul retro del computer. Il led di colore bianco posto sull'hard disk
dovrebbe essere acceso o lampeggiare.

Cliccare sul menù "Risorse" per verificare che sia disponibile una voce
TOSHIBA EXT

Se il disco è collegato, ma non risulta accessibile, provare a riavviare il
sistema.
Se il problema persiste e se è disponibile un disco esterno di scorta, 
provare con quello. Altrimenti chiedere assistenza e attendere un disco
di ricambio.

Qualora non sia possibile procedere al backup il sistema informerà ogni ora
del problema con un avviso che appare sullo schermo. La presenza dell'avviso
non pregiudica il funzionamento del sistema e la conservazione dei dati.


eof
else
echo "Il disco usb risulta correttamente collegato e funzionante"
fi

echo ""
echo "Lo script di backup è stato eseguito l'ultima volta:"
cat /home/mmo/.log/DolphinDetector/backup.timestamp
