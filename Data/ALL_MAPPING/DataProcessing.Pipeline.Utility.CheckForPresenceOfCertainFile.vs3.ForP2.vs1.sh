#!/bin/sh

beginTime1=`perl -e 'print time;'`
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

#RLMIDsffFile Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output
#RLMIDsffFile Ex:

RLMIDsffFile="$1"
File1="$2"

#rm /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.CheckForPresenceOfCertainFile.vs3.ForP2.vs1.${date1}.output 

OLD_IFS="$IFS" 
IFS=$'\n'

for DirAndsffFile in `cat $RLMIDsffFile`
do
	IFS=$OLD_IFS

	mainDir1=`echo $DirAndsffFile | awk '{ print $1 }'`
	indv1=`echo $DirAndsffFile | awk '{ print $1 }' | perl -F/ -lane 'print $F[10];'`
	baseFile1=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/(.*)\.sff/) { print $1; }'`

	echo $DirAndsffFile

#	echo $mainDir1/$baseFile1.$File1

	if [ ! -e $mainDir1/$baseFile1.$File1 ] ; then
#		echo "nana"
		echo $DirAndsffFile " Error1a" >> /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.CheckForPresenceOfCertainFile.vs3.ForP2.vs1.${date1}.output
	else
		fileSize1=`ls -lrt $mainDir1/. | grep $baseFile1.$File1$ | awk '{ print $5 }'`
		if [ $fileSize1 -lt "2000" ] ; then
			echo $DirAndsffFile " Error2a" >> /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.CheckForPresenceOfCertainFile.vs3.ForP2.vs1.${date1}.output
		fi
	fi
done

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
