#!/bin/bash


window_id=`wmctrl -l |grep baudline |grep -v view |cut -f1 -d" "`
mkdir  /tmp/livess/
rm -rf /tmp/livess/*

if ! test -z $window_id
then
   while test 1
   do
     for file in 1 2 3 4 5 6 7 8 9 10 11 12
     do
        rm -f /tmp/livess/*.$file.png
        timestamp=`date +"%Y%m%d_%H%M%S"`
        import  -window $window_id /tmp/livess/$timestamp.$file.png
        sleep 5s
     done
   done
fi
