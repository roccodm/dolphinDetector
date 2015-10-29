#!/bin/bash

data=`date +"%Y%m%d_%H%M%S"`
/home/mmo/dolphinDetector/report_funzionamento.sh > /home/mmo/.log/report_$data.txt
gedit /home/mmo/.log/report_$data.txt
