#!/bin/sh

#RLMIDsffFile Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.WorkingMainFile.Edited.output
#RLMIDsffFile Ex: 

RLMIDsffFile="$1"

OLD_IFS=$IFS
IFS=$'\n'

for DirAndsffFile in `cat $RLMIDsffFile`
do

#	mainDir=`echo $DirAndsffFile | awk '{ print $1 }'`
#	indv1=`echo $DirAndsffFile | awk '{ print $1 }' | perl -F/ -lane 'print $F[9];'`
#	baseFile1=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/(.*)\.sff/) { print $1; }'`

	mainDir2=`echo $DirAndsffFile | perl -F/\;/ -ane 'chomp(@F); my @vals1 = split(/\|/, $F[0]); print $vals1[0];' | perl -F/ -ane '$F[7] = "PostMerge"; if ($F[9] =~ m/(POOL\w+).*(\d\dRL)/) { $F[9] = $1 . "_" . $2;  print "/", join("/", @F[1..9]);}'`
	baseFileN=`echo $mainDir2 | perl -F/ -ane 'print $F[9];'`

#	echo $DirAndsffFile $mainDir2 $baseFileN

#	rm $mainDir/$baseFile1.fastq.stats
#	rm $mainDir/$baseFile1.QCed.fastq.gz
#	rm $mainDir/$baseFile1.QCed.fastq.stats
#	rm $mainDir/$baseFile1.QCed.fastq.log
#	rm $mainDir/$baseFile1.fastq.QCed.stats

#	rm $mainDir/stdin_prinseq_bad*

#	rm $mainDir/$baseFile1.QCed.sam*
#	rm $mainDir/$baseFile1.QCed.preGATK*

	rm $mainDir2/$baseFileN.QCed.preGATK.QCed.samplesMerged*

done


