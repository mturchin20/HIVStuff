#!/bin/sh

#Example: DataOrganization.CreatebamMergeList.vs1.20130909_231450.output 
mergeFileList1="$1"

rm ${mergeFileList1}.GetperFullBampostQCStats.vs2.output

OLD_IFS="$IFS" 
IFS=$'\n'

for fileDirList in `cat $mergeFileList1`
do
	
	IFS=$OLD_IFS
	
	FLAG1=`echo $fileDirList | perl -lane 'if ($F[0] =~ m/\#/) { print "1"; } else { print "0"; }'`
	
	if [ $FLAG1 == 1 ] ; then
		echo "Skip $fileDirList"
	elif [ $FLAG1 == 0 ] ; then
		
		mainDir1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); print $vals1[0];'`
		baseFile1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); my @vals2 = split(/\//, $vals1[0]); if ($vals2[10] =~ m/(POOL_P2_[0-9]+).*(\d\dRL)/) { print $1, "_", $2; } '`
		mainDir2=`echo $mainDir1 | perl -F/ -lane '$F[9] = "PostMerge"; if ($F[10] =~ m/(POOL_P2_[0-9]+).*(\d\dRL)/) { $F[10] = $1 . "_" . $2;  print "/", join("/", @F[1..10]);}'`

		cat $mainDir2/$baseFile1.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.stats >> ${mergeFileList1}.GetperFullBampostQCStats.vs2.output 	


	fi

done

