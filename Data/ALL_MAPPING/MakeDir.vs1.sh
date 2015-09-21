#!/bin/sh

for dir in `cat home_pg_ALL_Mapping_dirList.20130513.txt`
do
#	mkdir $dir
	for subDir in `cat $dir/home_pg_ALL_Mapping_${dir}_dirList.20130513.txt`
	do
#		mkdir $dir/$subDir
		mkdir $dir/$subDir/sff

		ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' > $dir/$subDir/sff/home_pg_ALL_Mapping_${dir}_${subDir}_sff_dirList.20130513.txt

		for sffFile in `cat $dir/$subDir/sff/home_pg_ALL_Mapping_${dir}_${subDir}_sff_dirList.20130513.txt`
		do
			ln -s /home/pg/ALL_MAPPING/$dir/$subDir/sff/$sffFile $dir/$subDir/sff/$sffFile
		done
	done
done
