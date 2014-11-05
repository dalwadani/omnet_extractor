#!/bin/bash
#: Title       : OMNET++ Scaller Extractor
#: Date Created: Mon Nov  3 12:14:40 GMT 2014
#: Last Edit   : Mon Nov  3 11:14:56 GMT 2014
#: Author      : Dhaifallah Alwadani
#: Version     : 0.1 alpha
#: Description : Extract values from .sca files and print them in a table
#: Options     : 

DATA=`grep "iterationvars2" $2 | sed 's/[,$]//g' | cut -f2 -d'"' `
VALUE_LINE=`grep -m 1 "$1" $2`
NAME=`echo "$VALUE_LINE" | awk 'BEGIN { FS = "\t" } ; { print $2 }'`
VAR=0

for x in $DATA
do
header+=`echo $x | cut -f1 -d'='` 
header+='\t'
done
header+="Model\t"$NAME
echo -e  $header


for i in ${@:2}
do
valuer=""
METRICS=""
VALUE_LINE=`grep "$1" $i`
DATA=`grep "iterationvars2" $i | sed 's/[,$]//g' | cut -f2 -d'"' `
VAL=$(echo "$VALUE_LINE" | awk  '{print  $2 "\t" $NF}')

while read DATA_LINE
do
for x in $DATA_LINE
do
METRICS+=`echo $x | cut -f2 -d'='` 
METRICS+='\t'
done
done <<< $DATA

while read "VALUE"
do
echo -e $METRICS "$VALUE"
done <<< "$VAL"


done