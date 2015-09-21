#!/bin/sh

beginTime1=`perl -e 'print time;'`

#rm DataOrganization.CombinePoolNameswsffFileIDs.output

###sffLinker1 example: DataOrganization.CombinePoolNameswsffFileIDs.Wed_May_15_16:48:09_CDT_2013.output
#sffLinker1 example: D

sffLinker1="$1"
MergeFolder="$2"
SearchTerm1="$3"

#date1=`date | perl -ane '$F[3] =~ s/:/_/g; print join("_", @F);'`
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

OLD_IFS="$IFS" 
IFS=$'\n'

#for sffListInfo in `cat sffListTempFile.txt`
for sffListInfo in `cat $sffLinker1`
do
	IFS=$OLD_IFS

	mainDir1=`echo $sffListInfo | awk '{ print $1 }'`
	baseFile1=`echo $sffListInfo | awk '{ print $2 }' | perl -ane 'if ($F[0] =~ m/(.*).sff/) { print $1; }'`
#	preGATKbam1=${baseFile1}.preGATK.bam
#	preGATKbam1=${baseFile1}.QCed.preGATK.QCed.bam
	searchFile1=${baseFile1}.${SearchTerm1}

#	echo $searchFile1

	fileFound1=`ls -lrt $mainDir1 | grep $searchFile1`

#	echo $fileFound1

	if [ -z "$fileFound1" ] ; then
		 echo $sffListInfo >> DataProcessing.Pipeline.CheckForPresenceOfCertainFile.vs2.${SearchTerm1}.${date1}.output
	else 
		
		numRecords1=`echo $fileFound1 | perl -ane 'print $#F;'`

		if [ $numRecords1 -gt "10" ] ; then
			echo "Error1a -- file entry has more than 1 record ($fileFound1)"
		else
			fileSize1=`echo $fileFound1 | awk '{ print $5 }'`
#			echo $fileSize1
			if [ $fileSize1 -lt "50" ] ; then
				 echo $sffListInfo >> DataProcessing.Pipeline.CheckForPresenceOfCertainFile.vs2.${SearchTerm1}.${date1}.output
			fi
		fi
	fi

#	if [ ! -e Pools/$dir/$subDir/$preGATKbam1 ] ; then
#	if [ ! -e $mainDir1/$searchFile1 ] ; then
#		echo $sffListInfo >> DataProcessing.Pipeline.CheckForPresenceOfCertainFile.vs2.${SearchTerm1}.${date1}.output 
#	elif
	

done

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
