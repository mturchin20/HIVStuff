#!/bin/sh

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

date1=`date | perl -ane 'print join("_", @F);'`

for dir in `cat home_pg_ALL_MAPPING_dirList.20130513.txt`
do
	
	for subDir in `cat $dir/home_pg_ALL_MAPPING_${dir}_dirList.20130513.txt`
	do

		ls -lrt $dir/$subDir/. | awk '{ print $9 }' | grep ".sff" | perl -slane 'print "/home/pg/michaelt/Data/ALL_MAPPING/" . $dir1 . "/" . $subDir1 . "\t" . $F[0];' -- -dir1=$dir -subDir1=$subDir >> DataOrganization.CollectAllIndvMIDRLsffFiles.${date1}.output 

	done
done
