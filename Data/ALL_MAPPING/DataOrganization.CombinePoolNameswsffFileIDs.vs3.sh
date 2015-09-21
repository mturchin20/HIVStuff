#!/bin/sh

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

#DIRLIST Ex: home_pg_ALL_MAPPING_dirList.20130513.txt
#sffFile1 Ex: /home/pg/michaelt/Data/sffFiles/home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.SortUniq.txt
#ARRAY Ex: MM5


DIRLIST1="$1" 
sffFile1="$2"
ARRAY="$3"
#date1=`date | perl -ane 'print join("_", @F);'`
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

for dir in `cat $DIRLIST1`
do
	for subDir in `cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/${DIRLIST1}.${dir}`
	do
	
#		echo $dir $subDir

#		PoolAndsffName=`ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' | perl -slane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1; } ' -- -subDir1=$subDir`
#		PoolAndsffName=`ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' | perl -sane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1, "\t"; system("cat ../sffFiles/home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.SortUniq.txt | grep $1 "); print "\n";} ' -- -subDir1=$subDir`
		Pool70Flag=`echo $subDir | perl -ane 'if ($F[0] =~ m/70/) { print "1"; } else { print "0"; }'`
		Pool70Flag=0		

		if [ $Pool70Flag -eq "0" ] ; then
			ls -lrt /home/pg/michaelt/Data/ALL_MAPPING/Pools/${ARRAY}/PreMerge/$dir/$subDir/sff/. | awk '{ print $9 }' | grep -v dirList | perl -sane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1, "\t"; system("cat $sffFile11 | grep $1 ");} ' -- -subDir1=$subDir -sffFile11=$sffFile1 >> /home/pg/michaelt/Data/ALL_MAPPING/DataOrganization.CombinePoolNameswsffFileIDs.vs3.${date1}.output
		elif [ $Pool70Flag -eq "1" ] ; then
			echo "Pool70 flag -- " $subDir
			ls -lrt $dir/$subDir/sff/. | awk '{ print $9 }' | perl -sane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1, "\t"; system("cat $sffFile11 | grep $1 ");} ' -- -subDir1=$subDir -sffFile11=$sffFile1  >>  /home/pg/michaelt/Data/ALL_MAPPING/DataOrganization.CombinePoolNameswsffFileIDs.vs3.${date1}.output
		else
			echo "Error1 - Pool70Flag ($Pool70Flag) is neither 0 or 1"
		fi

	done
done
