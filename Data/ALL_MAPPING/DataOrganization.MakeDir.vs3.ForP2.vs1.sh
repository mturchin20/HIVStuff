#!/bin/sh

#DIRLIST1 Ex: home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt 
#ARRAY Ex: MM5

DIRLIST1="$1"
ARRAY="$2"

#for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do

	if [ ! -d /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir ] ; then
		mkdir /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir
	fi

	if [ ! -d /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/sff ] ; then
		mkdir /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/sff
	fi

done
