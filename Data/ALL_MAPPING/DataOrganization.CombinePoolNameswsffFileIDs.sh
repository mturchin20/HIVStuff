#!/bin/sh

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

date1=`date | perl -ane 'print join("_", @F);'`

for dir in `cat home_pg_ALL_MAPPING_dirList.20130513.txt`
do
#	mkdir $dir
	for subDir in `cat $dir/home_pg_ALL_MAPPING_${dir}_dirList.20130513.txt`
	do
		
#		PoolAndsffName=`ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' | perl -slane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1; } ' -- -subDir1=$subDir`
#		PoolAndsffName=`ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' | perl -sane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1, "\t"; system("cat ../sffFiles/home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.SortUniq.txt | grep $1 "); print "\n";} ' -- -subDir1=$subDir`
		Pool70Flag=`echo $subDir | perl -ane 'if ($F[0] =~ m/70/) { print "1"; } else { print "0"; }'`

		if [ $Pool70Flag -eq "0" ] ; then
			ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' | perl -sane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1, "\t"; system("cat ../sffFiles/home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.SortUniq.txt | grep $1 ");} ' -- -subDir1=$subDir >> DataOrganization.CombinePoolNameswsffFileIDs.${date1}.output
		elif [ $Pool70Flag -eq "1" ] ; then
			echo $subDir
			ls -lrt $dir/$subDir/sff/. | awk '{ print $9 }' | perl -sane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1, "\t"; system("cat ../sffFiles/home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.SortUniq.txt | grep $1 ");} ' -- -subDir1=$subDir >> DataOrganization.CombinePoolNameswsffFileIDs.${date1}.output
		else
			echo "Error1 - Pool70Flag ($Pool70Flag) is neither 0 or 1"
		fi

		sffName=`echo $PoolAndsffName | awk '{ print $2 }'`
#		echo $PoolAndsffName
#		cat ../sffFiles/home_pg_ALL_MAPPING_ALL_Pools_sff_OrigLocations.Unedited.20130513.SortUniq.txt | grep $sffName | xargs echo $PoolAndsffName
#		ls -lrt /home/pg/ALL_MAPPING/$dir/$subDir/sff/. | awk '{ print $9 }' | perl -slane 'if ($F[0] =~ m/(.*)\.sff/) { print $subDir1, "\t", $1; } ' -- -subDir1=$subDir >> DataOrganization.CombinePoolNameswsffFileIDs.${date1}.output



#		for sffFile in `cat $dir/$subDir/sff/home_pg_ALL_Mapping_${dir}_${subDir}_sff_dirList.20130513.txt`
#		do
#			ln -s /home/pg/ALL_MAPPING/$dir/$subDir/sff/$sffFile $dir/$subDir/sff/$sffFile
#		done
	done
done
