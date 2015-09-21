#!/bin/sh

#RLMIDsffFile Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

RLMIDsffFile="$1"

#rm ${RLMIDsffFile}.GetperRegionpostQCStats.vs2.output
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

OLD_IFS=$IFS
IFS=$'\n'

for DirAndsffFile in `cat $RLMIDsffFile`
do

	mainDir1=`echo $DirAndsffFile | awk '{ print $1 }'`
	indv1=`echo $DirAndsffFile | awk '{ print $1 }' | perl -F/ -lane 'print $F[10];'`
	baseFile1=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/(.*)\.sff/) { print $1; }'`

	cat $mainDir1/$baseFile1.QCed.preGATK.QCed.bam.stats >> ${RLMIDsffFile}.GetperRegionpostQCStats.vs3.${date1}.output

done


