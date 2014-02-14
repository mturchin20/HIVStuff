#!/bin/sh

beginTime1=`perl -e 'print time;'`

#rm DataOrganization.CombinePoolNameswsffFileIDs.output
#DIRLIST1 Ex: home_pg_ALL_MAPPING_dirList.WorkingMainList.txt 
#sffLinker1 Ex: DataOrganization.CombinePoolNameswsffFileIDs.Wed_May_15_16:48:09_CDT_2013.output
##### Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

DIRLIST1="$1"
#File1="$1"
#sffLinker1="$2"
MergeFolder="$2"

#date1=`date | perl -ane '$F[3] =~ s/:/_/g; print join("_", @F);'`
#date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

: <<'END'

OLD_IFS="$IFS" 
IFS=$'\n'

for Indv in `cat $File1`
do
	
	IFS=$OLD_IFS
	dir1=`echo $Indv | awk '{ print $1 }'`
	baseFile1=`echo $Indv | awk '{ print $2 }' | perl -ane 'if ($F[0] =~ m/(.*).sff/) { print $1; }'`

	rm ${dir1}/${baseFile1}.preGATK* ${dir1}/${baseFile1}.sam*

done

#/home/pg/michaelt/Data/ALL_MAPPING/Pools/mapping_pool_1-46/POOL01-01RL   HSMYABW02.RL1.sff

END

#for dir in `cat home_pg_ALL_MAPPING_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do

	echo $dir

#	for subDir in `cat $dir/home_pg_ALL_MAPPING_${dir}_dirList.20130513.txt`
	for subDir in `cat Pools/$MergeFolder/$dir/${DIRLIST1}.${dir}`
	do

		rm Pools/$MergeFolder/$dir/$subDir/*preGATK* Pools/$MergeFolder/$dir/$subDir/*sam.gz

#		cat $file1 | grep $subDir > sffListTempFile.txt

#		OLD_IFS="$IFS" 
#		IFS=$'\n'

#		for sffListInfo in `cat sffListTempFile.txt`
#		do
#			IFS=$OLD_IFS
	
#			baseFile1=`echo $sffListInfo | awk '{ print $2 }' | perl -ane 'if ($F[0] =~ m/(.*).sff/) { print $1; }'`
#			preGATKbam1=${baseFile1}.preGATK.bam
#			preGATKsam1=${baseFile1}.preGATK.sam.gz
#			preGATKsam1=${baseFile1}.preGATK.sam.gz

#			rm Pools/$MergeFolder/$dir/$subDir/${$baseFile1}.preGATK* Pools/$MergeFolder/$dir/$subDir/${$baseFile1}.sam*

#			if [ ! -e $dir/$subDir/$preGATKbam1 ] ; then
#				echo $sffListInfo >> DataProcessing.CheckForPresenceOfCertainFile.${date1}.output 
#			fi

#		done
	done
done


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
