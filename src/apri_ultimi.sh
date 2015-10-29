#!/bin/bash


file=`tail /home/mmo/.log/DolphinDetector/recorder.filelist  -n 11 | head -n 10 | zenity  --list  --title "Search Results" --text "Ultime registrazioni" --column "Files"`
if test -n "$file"
then
   /home/mmo/baudline/baudline -tsession view2 -palette ~/baudline/palettes/rocco3 $file
fi


