#!/bin/sh

DIRLIST1="$1"
#date1=`date | perl -ane 'print join("_", @F);'`
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

#for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do
#	mkdir $dir
#	for subDir in `cat $dir/home_pg_ALL_Mapping_${dir}_dirList.20130513.txt`
	for subDir in `cat Pools/$dir/${DIRLIST1}.${dir}`
	do

#		echo $date1
#		echo $subDir
#		ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $11 }' >> ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.20130513.txt
		ls -lrt /home/pg/ALL_MAPPING/$dir\ /$subDir/sff/. | awk '{ print $11 }' >> ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.${date1}.txt
#		ls -lrt /home/pg/ALL_MAPPING/$dir\ /$subDir/sff/. | awk '{ print $11 }' >> ../sffFiles/home_pg_ALL_Mapping_ALL_Pools_sff_OrigLocations.Unedited.vs2.20130831_103251.txt

#		for sffFile in `cat $dir/$subDir/sff/home_pg_ALL_Mapping_${dir}_${subDir}_sff_dirList.20130513.txt`
#		do
#			ln -s /home/pg/ALL_MAPPING/$dir/$subDir/sff/$sffFile $dir/$subDir/sff/$sffFile
#		done
	done
done
