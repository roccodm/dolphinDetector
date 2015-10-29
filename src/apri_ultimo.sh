#!/bin/bash


file=`tail /home/mmo/.log/DolphinDetector/recorder.filelist  -n 2 | head -n 1`

/home/mmo/baudline/baudline -tsession view2 -palette ~/baudline/palettes/rocco3 $file
