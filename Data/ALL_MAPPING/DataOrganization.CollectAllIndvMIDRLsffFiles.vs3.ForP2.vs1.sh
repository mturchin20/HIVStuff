#!/bin/sh

#DIRLIST1 Ex: home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt 
#ARRAY Ex: MM5

DIRLIST1="$1"
ARRAY="$2"

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

#date1=`date | perl -ane 'print join("_", @F);'`
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

#for dir in `cat home_pg_ALL_MAPPING_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do

	ls -lrt /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/. | awk '{ print $9 }' | grep ".sff" | perl -slane 'print "/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/" . $array1 . "/PreMerge/" . $dir1 . "\t" . $F[0];' -- -dir1=$dir -array1=$ARRAY >> /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataOrganization.CollectAllIndvMIDRLsffFiles.vs3.ForP2.vs1.${date1}.output 

done
