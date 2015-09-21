#!/bin/sh

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

#DIRLIST1 Ex: home_pg_ALL_MAPPING_dirList.20130827.NotCreatedYet.txt 
#sffLinker1 Ex: DataOrganization.CombinePoolNameswsffFileIDs.20130828_124947.output

DIRLIST1="$1"
sffLinker1="$2"

#date1=`date | perl -ane 'print join("_", @F);'`
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

#for dir in `cat home_pg_ALL_MAPPING_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do
	
#	for subDir in `cat $dir/home_pg_ALL_MAPPING_${dir}_dirList.20130513.txt`
	for subDir in `cat Pools/PreMerge/$dir/${DIRLIST1}.${dir}`
	do

		cat $sffLinker1 | grep $subDir > sffListTempFile.txt

		OLD_IFS="$IFS" 
		IFS=$'\n'

		for sffListInfo in `cat sffListTempFile.txt`
		do
			IFS=$OLD_IFS
	
			PoolRLID=`echo $sffListInfo | awk '{ print $1 }' | perl -ane 'if ($F[0] =~ m/.*(\d)(\d)(RL)/) { if ($1 == 0) { print $3 . $2; } else { print $3 . $1 . $2; }}'`
#			echo $sffListInfo
#			echo ""
#			echo $PoolRLID
			sffFileRLID=`echo $sffListInfo | awk '{ print $2 }' | perl -sane 'print $F[0] . "." . $RLID . ".sff"; ' -- -RLID=$PoolRLID`
#			echo $sffFileRLID
			mainFileLoc=`echo $sffListInfo | awk '{ print $3 }' | perl -F/ -sane 'if ($F[$#F] =~ m/(.*).sff/) { $F[$#F] = $1; } print "/home/pg/michaelt/Data/sffFiles/" . join("/", @F[4..8]) . "/" . $sffFileFinal;' -- -sffFileFinal=$sffFileRLID`
#			echo $mainFileLoc
#			echo $PoolRLID $sffFileRLID $mainFileLoc

#			echo $PoolRLID

			ln -s $mainFileLoc Pools/PreMerge/$dir/$subDir/$sffFileRLID

		done
	done
done
