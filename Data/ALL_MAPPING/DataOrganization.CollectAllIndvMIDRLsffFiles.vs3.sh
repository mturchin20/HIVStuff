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
	
#	for subDir in `cat $dir/home_pg_ALL_MAPPING_${dir}_dirList.20130513.txt`
	for subDir in `cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/${DIRLIST1}.${dir}`
	do

		ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir/. | awk '{ print $9 }' | grep ".sff" | perl -slane 'print "/home/pg/michaelt/Data/ALL_MAPPING/Pools/" . $array1 . "/PreMerge/" . $dir1 . "/" . $subDir1 . "\t" . $F[0];' -- -dir1=$dir -subDir1=$subDir -array1=$ARRAY >> DataOrganization.CollectAllIndvMIDRLsffFiles.vs3.${date1}.output 
#		ls -lrt Pools/PreMerge/$dir/$subDir/. | awk '{ print $9 }' | grep ".sff" | perl -slane 'print "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/" . $dir1 . "/" . $subDir1 . "\t" . $F[0];' -- -dir1=$dir -subDir1=$subDir >> DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130831_103352.output 

	done
done
