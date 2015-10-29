#!/usr/bin/python

import sys
import os

filename=sys.argv[1]
elenco = open(filename).read().splitlines()

impianto = open("/home/mmo/dolphinDetector/impianto.txt").read().splitlines()[0]

dirs=os.listdir("/data")

for dir in dirs:
   if dir!="lost+found":
     if not dir in elenco:
        print "faccio il backup di "+dir
        cmd="rsync -h -v -r -P -t --exclude '*.wav'  /data/%s /media/mmo/TOSH*/%s/audiofiles/" % (dir,impianto)
        os.system(cmd)
     else:
         print "non faccio il backup di "+dir


