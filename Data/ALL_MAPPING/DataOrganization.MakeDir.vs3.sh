#!/bin/sh

#DIRLIST1 Ex: home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt 
#ARRAY Ex: MM5

DIRLIST1="$1"
ARRAY="$2"

#for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do

	for subDir in `cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/${DIRLIST1}.${dir}`
	do
		if [ ! -d /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir ] ; then
			mkdir /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir
		fi

		if [ ! -d /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir/sff ] ; then
			mkdir /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir/sff
		fi

		ls -lrt /home/pg/${ARRAY}_ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir/sff/${DIRLIST1}.${dir}.${subDir}.sff
#		ls -lrt /home/pg/ALL_MAPPING/$dir\ /$subDir/sff/. | awk '{ print $9 }' > Pools/PreMerge/$dir/$subDir/sff/${DIRLIST1}.${dir}.${subDir}.sff

#		for sffFile in `cat Pools/PreMerge/$dir/$subDir/sff/home_pg_ALL_Mapping_${dir}_${subDir}_sff_dirList.20130513.txt`
		for sffFile in `cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir/sff/${DIRLIST1}.${dir}.${subDir}.sff`
		do
			ln -s /home/pg/${ARRAY}_ALL_MAPPING/${dir}/$subDir/sff/$sffFile /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir/sff/$sffFile
#			ln -s /home/pg/ALL_MAPPING/${dir}\ /$subDir/sff/$sffFile Pools/PreMerge/$dir/$subDir/sff/$sffFile
		done
	done
done
