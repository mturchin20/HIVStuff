#!/bin/sh

#RLMIDsffFile Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output

RLMIDsffFile="$1"

rm DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.output

OLD_IFS=$IFS
IFS=$'\n'

for DirAndsffFile in `cat $RLMIDsffFile`
do

	mainDir1=`echo $DirAndsffFile | awk '{ print $1 }'`
	indv1=`echo $DirAndsffFile | awk '{ print $1 }' | perl -F/ -lane 'print $F[9];'`
	baseFile1=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/(.*)\.sff/) { print $1; }'`

	cat $mainDir1/$baseFile1.QCed.preGATK.QCed.bam.stats >> DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.vs2.output 

done


