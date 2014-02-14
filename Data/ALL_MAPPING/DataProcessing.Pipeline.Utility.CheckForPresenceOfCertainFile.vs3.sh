#!/bin/sh

beginTime1=`perl -e 'print time;'`

#RLMIDsffFile Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output
#RLMIDsffFile Ex:

RLMIDsffFile="$1"

rm DataProcessing.Pipeline.Utility.CheckForPresenceOfCertainFile.vs3.output 

OLD_IFS="$IFS" 
IFS=$'\n'

for DirAndsffFile in `cat $RLMIDsffFile`
do
	IFS=$OLD_IFS

	mainDir1=`echo $DirAndsffFile | awk '{ print $1 }'`
	indv1=`echo $DirAndsffFile | awk '{ print $1 }' | perl -F/ -lane 'print $F[9];'`
	baseFile1=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/(.*)\.sff/) { print $1; }'`

	if [ -z $mainDir1/$baseFile1.QCed.preGATK.QCed.bam.stats ] ; then
		echo "Error1a: " $DirAndsffFile >> DataProcessing.Pipeline.Utility.CheckForPresenceOfCertainFile.vs3.output
	else
		fileSize1=`ls -lrt $mainDir1/. | grep $baseFile1.QCed.preGATK.QCed.bam.stats$ | awk '{ print $5 }'`
		if [ $fileSize1 -lt "50" ] ; then
			echo "Error2a: " $DirAndsffFile >> DataProcessing.Pipeline.Utility.CheckForPresenceOfCertainFile.vs3.output
		fi
	fi
done

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
