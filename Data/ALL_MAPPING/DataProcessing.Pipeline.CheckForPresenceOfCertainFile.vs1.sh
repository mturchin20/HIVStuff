#!/bin/sh

beginTime1=`perl -e 'print time;'`

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

#file1 example: DataOrganization.CombinePoolNameswsffFileIDs.Wed_May_15_16:48:09_CDT_2013.output
file1="$1"

#date1=`date | perl -ane '$F[3] =~ s/:/_/g; print join("_", @F);'`
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

#for dir in `cat home_pg_ALL_MAPPING_dirList.20130513.txt`
for dir in `cat $DIRLIST1`
do
	
	for subDir in `cat $dir/home_pg_ALL_MAPPING_${dir}_dirList.20130513.txt`
	do

		cat $file1 | grep $subDir > sffListTempFile.txt

		OLD_IFS="$IFS" 
		IFS=$'\n'

		for sffListInfo in `cat sffListTempFile.txt`
		do
			IFS=$OLD_IFS
	
			baseFile1=`echo $sffListInfo | awk '{ print $2 }' | perl -ane 'if ($F[0] =~ m/(.*).sff/) { print $1; }'`
#			preGATKbam1=${baseFile1}.preGATK.bam
			preGATKbam1=${baseFile1}.QCed.preGATK.QCed.bam

			if [ ! -e $dir/$subDir/$preGATKbam1 ] ; then
				echo $sffListInfo >> DataProcessing.CheckForPresenceOfCertainFile.${date1}.output 
			fi

		done
	done
done

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
