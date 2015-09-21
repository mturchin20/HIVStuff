#!/bin/sh

#DIRLIST Ex: /home/pg/michaelt/Data/ALL_MAPPING/home_pg_ALL_MAPPING_dirList.20140321.NotCreatedYet.txt
#ARRAY Ex: MM5

DIRLIST1="$1"
ARRAY="$2"
#date1=`date | perl -ane 'print join("_", @F);'`
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

#for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do
	for subDir in `cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/${DIRLIST1}.${dir}`
	do

		ls -lrt /home/pg/${ARRAY}_ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $11 }' >> /home/pg/michaelt/Data/sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs3.${date1}.txt
#		ls -lrt /home/pg/${ARRAY}_ALL_MAPPING/$dir\ /$subDir/sff/. | awk '{ print $11 }' >> ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.${date1}.txt

	done
done
