#!/bin/bash
zoneName=$1
oldResc=$2
newResc=$3
newPath=$4
iadmin mkresc replResc replication
iadmin mkresc $newResc 'unix file system' $newPath
iadmin addchildtoresc replResc $oldResc
iadmin addchildtoresc replResc $newResc
iadmin modresc replResc rebalance
iadmin rmchildfromresc replResc $oldResc
itrim -rM -N 1 -S $oldResc /$zoneName
iadmin rmresc $oldResc
iadmin rmchildfromresc replResc $newResc
iadmin rmresc replResc
 
