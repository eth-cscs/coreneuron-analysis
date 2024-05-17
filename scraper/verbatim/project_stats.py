#!/usr/bin/python

import re
import sys
import subprocess
from zipfile import ZipFile
import os
from operator import itemgetter

rng=[-1,-1]
if len(sys.argv) == 2 :
    b=int(sys.argv[1])
    rng=[b,b]

if len(sys.argv) == 3 :
    b = int(sys.argv[1])
    e = int(sys.argv[2])
    rng=[b,e]

class bcolors:
    Red='\033[1;31m'
    Green='\033[1;32m'
    Yellow='\033[1;33m'
    Blue='\033[1;34m'
    Purple='\033[1;35m'
    Cyan='\033[1;36m'
    White='\033[1;37m'
    Endc = '\033[0m'

# extract verbatim blocks from zip file
allblock=dict()
blockset=dict()
projectblocks=dict()
errorfiles=list()
zipfiles = [ f for f in os.listdir(os.path.abspath(os.path.dirname(__file__))) if f.endswith(".zip") ]
#zipfiles = ["765.zip"]

mod_projects=0

for zipname in zipfiles :
    try:
        z = ZipFile(zipname,"r")
    except:
        print "dodgy zip mate : %s" %(zipname)
        continue
    #exemptfiles = ["intf6.mod", "intf6_.mod", "intf_.mod", "intf.mod", "intfsw.mod", "vecst.mod", "stats.mod", "misc.mod"]
    exemptfiles = []
    modfiles = [ mod for mod in z.namelist() if mod.endswith(".mod") and os.path.basename(mod) not in exemptfiles ]
    mid = zipname.split(".")[0]
    projectblocks[mid]=[0, 0, 0]
    projectblocks[mid][1]=len(modfiles)
    if len(modfiles)>0 :
        blockset[mid]=[]
        mod_projects = mod_projects+1
    # get all verbatim blocks and their metadata for each mod files
    for mfile in modfiles:
        mf = z.open(mfile, "r" )
        vb_block=""
        verbatim=False
        return_0=False
        n_line_blocks=0
        startline=0
        blocks=dict()
        for n,l in enumerate(mf.readlines()):
            if "VERBATIM" == l.strip():
                verbatim=True
                projectblocks[mid][0]+=1
                startline=n
            if verbatim:
                vb_block+="%s\n" % ( l.strip() )
                n_line_blocks+=1
                if "return 0" in l:
                    return_0=True
            if "ENDVERBATIM" == l.strip():
                blocks[startline]=vb_block
                verbatim=False
                vb_block=""
                if n_line_blocks == 3 and return_0 == True:
                    projectblocks[mid][2]+=1
        if len(blocks) > 0:
            allblock[(mid, mfile)]=blocks
            blockset[mid].append((mfile,blocks))
        mf.close()
    z.close()

uniq_blocks=set([ ''.join(b.values()) for b in allblock.values()])
verbatim_projects=[ (k,v) for k,v in projectblocks.items() if v[0] > 0]
n_projects=len(verbatim_projects)
n_vbblocks=sum([ v[0] for v in projectblocks.values()])
n_return_0=sum([ v[2] for v in projectblocks.values()])
print "Total number of projects with NMODL files : %d" % ( mod_projects )
print "Total number of verbatim blocks: %d (uniq blocks %d) for %d projects" % ( n_vbblocks, len(uniq_blocks), n_projects )
