#!/bin/sh

DIRLIST1="$1"

#for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do
#	$OUTFILE1=`echo $DIRLIST | perl -sane 'if ($F[0] =~ m/
	
#	ls -lrt /home/pg/ALL_MAPPING/$dir/. | awk '{ print $9 }' > $dir/home_pg_ALL_Mapping_${dir}_dirList.20130513.txt
	ls -lrt /home/pg/ALL_MAPPING/$dir/. | awk '{ print $9 }' > Pools/PreMerge/$dir/${DIRLIST1}.${dir}
done
