#!/bin/sh

#DIRLIST Ex: home_pg_ALL_MAPPING_dirList.20140321.NotCreatedYet.txt
#ARRAY Ex: MM5

DIRLIST1="$1"
ARRAY="$2"

#for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do
#	$OUTFILE1=`echo $DIRLIST | perl -sane 'if ($F[0] =~ m/
	
	if [ ! -d /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir ] ; then
		mkdir /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir
	fi

#	ls -lrt /home/pg/ALL_MAPPING/$dir/. | awk '{ print $9 }' > $dir/home_pg_ALL_Mapping_${dir}_dirList.20130513.txt
	ls -lrt /home/pg/${ARRAY}_ALL_MAPPING/$dir/. | awk '{ print $9 }' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/${DIRLIST1}.${dir}

done
