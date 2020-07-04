#!/bin/bash

#
# Variables.
#
rooturl="https://docs.google.com/spreadsheets/d/"
exportcsv="/export?format=csv&gid="
documentid="14TWw0lf2x6y8ji5Zd7zv9sIIVixU33irCM-i9CIrmo4"
sheetid01="0"
sheetid02="1317599353"
sheetid03="1874348923"
sheetid04="1200297433"
sheetid05="820026181"
listfile="/web/lists/cryptojacking_campaign.list.txt"

#
# Pull in the lists from individual sheets and write to tmp location.
#
curl -s -k -L "$rooturl$documentid$exportcsv$sheetid01" | awk -F , '{print $1}' | awk -F : '{print $1}' | tail -n +2 | tee $listfile.tmp
curl -s -k -L "$rooturl$documentid$exportcsv$sheetid02" | awk -F , '{print $1}' | awk -F : '{print $1}' | tail -n +2 | tee -a $listfile.tmp
curl -s -k -L "$rooturl$documentid$exportcsv$sheetid03" | awk -F , '{print $1}' | tail -n +2 | tee -a $listfile.tmp
curl -s -k -L "$rooturl$documentid$exportcsv$sheetid04" | awk -F , '{print $1}' | tail -n +2 | tee -a $listfile.tmp
curl -s -k -L "$rooturl$documentid$exportcsv$sheetid05" | awk -F , '{print $1}' | awk -F '//' '{print $2}' | grep -v '^$' | tail -n +2 | tee -a $listfile.tmp

#
# Sort, uniq and write to listfile.
#
sort $listfile.tmp | uniq | tee $listfile

#
# Cleanup tmp.
#
rm $listfile.tmp
