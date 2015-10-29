#!/bin/bash

nohup ams -J -l /home/mmo/dolphinDetector/click_detector_improved.ams -N filtro_cuffie -n 2> /home/mmo/.log/ams.log &
sleep 3s
jack_connect amsfiltro_cuffie_1:out_0 system:playback_1
jack_connect amsfiltro_cuffie_1:out_1 system:playback_2
jack_connect system:capture_1 amsfiltro_cuffie_1:in_1
jack_connect system:capture_1 amsfiltro_cuffie_1:in_0
jack_disconnect baudline_mmo:out_1 system:playback_1

