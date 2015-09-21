#!/bin/sh

#DIRLIST1 Ex: home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt 

DIRLIST1="$1"

#for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do

#	mkdir $dir


#	for subDir in `cat $dir/home_pg_ALL_Mapping_${dir}_dirList.20130513.txt`
	for subDir in `cat Pools/PreMerge/$dir/${DIRLIST1}.${dir}`
	do
		mkdir Pools/PreMerge/$dir/$subDir
		mkdir Pools/PreMerge/$dir/$subDir/sff

#		ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' > Pools/PreMerge/$dir/$subDir/sff/home_pg_ALL_Mapping_${dir}_${subDir}_sff_dirList.20130513.txt
		ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' > Pools/PreMerge/$dir/$subDir/sff/${DIRLIST1}.${dir}.${subDir}.sff
#		ls -lrt /home/pg/ALL_MAPPING/$dir\ /$subDir/sff/. | awk '{ print $9 }' > Pools/PreMerge/$dir/$subDir/sff/${DIRLIST1}.${dir}.${subDir}.sff

#		for sffFile in `cat Pools/PreMerge/$dir/$subDir/sff/home_pg_ALL_Mapping_${dir}_${subDir}_sff_dirList.20130513.txt`
		for sffFile in `cat Pools/PreMerge/$dir/$subDir/sff/${DIRLIST1}.${dir}.${subDir}.sff`
		do
			ln -s /home/pg/ALL_MAPPING/${dir}/$subDir/sff/$sffFile Pools/PreMerge/$dir/$subDir/sff/$sffFile
#			ln -s /home/pg/ALL_MAPPING/${dir}\ /$subDir/sff/$sffFile Pools/PreMerge/$dir/$subDir/sff/$sffFile
		done
	done
done
