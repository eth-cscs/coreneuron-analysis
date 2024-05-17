#!/usr/bin/python2.7


import re
import sys
import subprocess
from zipfile import ZipFile
import os
from operator import itemgetter

def exec_command(cmd):
    #print cmd
    subprocess.call(cmd.split(' '))

# get the meta data from the html file
inputfile="modeldb.html"
f = open(inputfile,"r")
lines = f.readlines()
reg_pattern_downid='model=[0-9]*">'
reg_pattern_modid='<td>[0-9]+</td>'
for l in lines:
    downid = re.findall(reg_pattern_downid, l)
    if len(downid) > 0:
        modid = re.findall(reg_pattern_modid, l)
        break
f.close()

# extract verbatim blocks from zip file
allblock=dict()
projectblocks=dict()
errorfiles=list()
downloaded = failed = 0
for r_mid, r_did in zip(modid, downid):
    did = int(r_did.translate(None, 'model=">'))
    mid = int(r_mid.translate(None, '</td>'))
    # first is number of blocks
    # second is number of modfiles
    # third number of blocks return_0
    projectblocks[mid]=[0, 0, 0]
    try:
        # get the zip file
        url="https://senselab.med.yale.edu/ModelDB/eavBinDown.cshtml?o=%d&a=23&mime=application/zip" % ( did )
        zipname = "%d.zip" % ( mid )
        # do it silently
        wget_cmd="wget --quiet %s -O %s" % ( url, zipname )
        if not os.path.isfile(zipname):
            exec_command(wget_cmd)
        if os.stat(zipname).st_size == 0:
            os.remove(zipname)
        z = ZipFile(zipname,"r")
        print "%10s downloaded" %(zipname)
        downloaded += 1
    except:
        print "%10s error" %(zipname)
        errorfiles.append(zipname)
        failed += 1
        continue

print "------------------------------------------------"
print "%6d attempted" %(failed + downloaded)
print "%6d success" %(downloaded)
print "%6d failed" %(failed)
print "------------------------------------------------"
