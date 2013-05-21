#!/bin/sh

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

#file1 example: DataOrganization.CombinePoolNameswsffFileIDs.Wed_May_15_16:48:09_CDT_2013.output
file1="$1"

date1=`date | perl -ane 'print join("_", @F);'`

for dir in `cat home_pg_ALL_MAPPING_dirList.20130513.txt`
do
	
	for subDir in `cat $dir/home_pg_ALL_MAPPING_${dir}_dirList.20130513.txt`
	do

		cat $file1 | grep $subDir > sffListTempFile.txt

		OLD_IFS="$IFS" 
		IFS=$'\n'

		for sffListInfo in `cat sffListTempFile.txt`
		do
			IFS=$OLD_IFS
	
			PoolRLID=`echo $sffListInfo | awk '{ print $1 }' | perl -ane 'if ($F[0] =~ m/.*(\d)(\d)(RL)/) { if ($1 == 0) { print $3 . $2; } else { print $3 . $1 . $2; }}'`
#			FileRLID=`echo $sffListInfo | awk '{ print $2 }' | perl -sane 'if ($F[0] =~ m/(.*).sff/) { print $1 . "." . $RLID; }' -- -RLID=$PoolRLID`
			FileRLID=`echo $sffListInfo | awk '{ print $2 }' | perl -ane 'if ($F[0] =~ m/(.*).sff/) { print $1; }'`

			if grep Total_reads $dir/$subDir/$FileRLID.fastq.stats ; then
				cat $dir/$subDir/$FileRLID.fastq.stats | grep Total_reads >> DataOrganization.CheckfastqStatsFiles.${date1}.output 
			else
				echo "No stats file or Total_reads in $dir/$subDir/$FileRLID.fastq.stats" >> DataOrganization.CheckfastqStatsFiles.${date1}.output
			fi

#			ln -s $mainFileLoc $dir/$subDir/$sffFileRLID

		done
	done
done
