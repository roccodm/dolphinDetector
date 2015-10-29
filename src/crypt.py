#!/usr/bin/python
#################################################################
#                       Dolphin detector                        #  
#                      versione 2.0 - 2015		        #		
#################################################################

# Avviato via crontab con
# find /data -iname "*".wav -exec /home/mmo/dolphinDetector/crypt.py {} \;

# Ritardo per cifrare i file di log
delay=360 # 360 minuti = 6 ore

import sys
import re
import datetime
import os
import time


file=sys.argv[1]
try:
   year,month,day,hh,mm,ss=re.findall("/data/(.*)-(.*)-(.*)/.*_(.*)\.(.*)\.(.*)_log.*",file)[0]
   limite=datetime.datetime.now()-datetime.timedelta(minutes=delay)
   corrente=datetime.datetime(int(year),int(month),int(day),int(hh),int(mm),int(ss))
except:
   limite=1
   corrente=0   

print "Processo file: "+file

if limite>corrente:
   cmd="gpg -e -r Chiave -z 0 " + file
   os.system(cmd)
   if os.path.isfile(file+".gpg"): # se il file esiste
      if os.path.getsize(file+".gpg")>2000000: #se est abbastanza grande
         cmd="rm "+file
         os.system(cmd)
      time.sleep(5) # per evitare il cpu burst
