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
#			sffListInfo=`cat DataOrganization.CombinePoolNameswsffFileIDs.Wed_May_15_16:48:09_CDT_2013.output | grep $subDir`

#			echo $sffListInfo | awk '{ print $1 }' | perl -lane 'if ($F[0] =~ m/.*(\d)(\d)(RL)/) { print $1 };'
	
			PoolRLID=`echo $sffListInfo | awk '{ print $1 }' | perl -ane 'if ($F[0] =~ m/.*(\d)(\d)(RL)/) { if ($1 == 0) { print $3 . $2; } else { print $3 . $1 . $2; }}'`
#			echo $sffListInfo
#			echo $sffListInfo
#			echo ""
#			echo $PoolRLID
			sffFileRLID=`echo $sffListInfo | awk '{ print $2 }' | perl -sane 'print $F[0] . "." . $RLID . ".sff"; ' -- -RLID=$PoolRLID`
#			echo $sffFileRLID
			mainFileLoc=`echo $sffListInfo | awk '{ print $3 }' | perl -F/ -sane 'if ($F[$#F] =~ m/(.*).sff/) { $F[$#F] = $1; } print "/home/pg/michaelt/Data/sffFiles/" . join("/", @F[4..8]) . "/" . $sffFileFinal;' -- -sffFileFinal=$sffFileRLID`
#			echo $mainFileLoc
#			echo $PoolRLID $sffFileRLID $mainFileLoc

#			echo $PoolRLID

			ln -s $mainFileLoc $dir/$subDir/$sffFileRLID

		done


#		for sffFile in `cat $dir/$subDir/sff/home_pg_ALL_Mapping_${dir}_${subDir}_sff_dirList.20130513.txt`
#		do
#			ln -s /home/pg/ALL_MAPPING/$dir/$subDir/sff/$sffFile $dir/$subDir/sff/$sffFile
#		done
	done
done
