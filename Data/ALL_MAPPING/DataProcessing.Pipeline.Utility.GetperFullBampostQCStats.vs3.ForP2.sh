#!/bin/sh

#Example: DataOrganization.CreatebamMergeList.vs1.20130909_231450.output 
mergeFileList1="$1"

#rm ${mergeFileList1}.GetperFullBampostQCStats.vs2.output
date1=`date "+%F_%k%M%S" | sed 's/\-//g'`

OLD_IFS="$IFS" 
IFS=$'\n'

for fileDirList in `cat $mergeFileList1`
do
	
	IFS=$OLD_IFS
	
	FLAG1=`echo $fileDirList | perl -lane 'if ($F[0] =~ m/\#/) { print "1"; } else { print "0"; }'`
	
	if [ $FLAG1 == 1 ] ; then
		echo "Skip $fileDirList"
	elif [ $FLAG1 == 0 ] ; then
	
#/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PreMerge/mapping_pool_106-124/POOL106-04RL|H8V4AIH01.RL4.sff;/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PreMerge/mapping_pool_106-124/POOL106-04RL|H8V4AIH02.RL4.sff;/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PreMerge/mapping_pool_106-124/POOL106-04RL|H9Y2FG201.RL4.sff;/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PreMerge/mapping_pool_106-124/POOL106-04RL|H9Y2FG202.RL4.sff;
#/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_106-124/POOL106_05RL/POOL106.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.stats
#/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PreMerge/POOL_P2_103-07RL|IEFTADQ01.RL7.sff;/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PreMerge/POOL_P2_103-07RL|IEFTADQ02.RL7.sff;/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PreMerge/POOL_P2_103-07RL|IEFRFFT01.RL7.sff;/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PreMerge/POOL_P2_103-07RL|IEFRFFT02.RL7.sff;
#/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PreMerge/POOL_P2_103-07RL


#		echo $fileDirList

		mainDir1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); print $vals1[0];'`
#		baseFile1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); my @vals2 = split(/\//, $vals1[0]); if ($vals2[11] =~ m/(POOL\w+).*(\d\dRL)/) { $printVal1 = $1 . "_" . $2; $printVal1 =~ s/\-/\_/g; print $printVal1; } '`
#		baseFile1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); my @vals2 = split(/\//, $vals1[0]); if ($vals2[12] =~ m/(POOL\w+).*(\d\dRL)/) { print $1, "_", $2; } '`
		baseFile1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); my @vals2 = split(/\//, $vals1[0]); if ($vals2[10] =~ m/(POOL_P2_\w+).*(\d\dRL)/) { print $1, "_", $2; } '`
#		mainDir2=`echo $mainDir1 | perl -F/ -lane '$F[9] = "PostMerge"; if ($F[11] =~ m/(POOL\w+).*(\d\dRL)/) { $F[11] = $1 . "_" . $2;  $F[11] =~ s/\-/\_/g; print "/", join("/", @F[1..11]);}'`
#		mainDir2=`echo $mainDir1 | perl -F/ -lane '$F[10] = "PostMerge"; if ($F[12] =~ m/(POOL\w+).*(\d\dRL)/) { $F[12] = $1 . "_" . $2; print "/", join("/", @F[1..12]);}'`
		mainDir2=`echo $mainDir1 | perl -F/ -lane '$F[9] = "PostMerge"; if ($F[10] =~ m/(POOL_P2_\w+).*(\d\dRL)/) { $F[10] = $1 . "_" . $2; print "/", join("/", @F[1..10]);}'`

#		echo $fileDirList 
#		echo $mainDir1 
#		echo $baseFile1 
#		echo $mainDir2

#		echo "cat $mainDir2/$baseFile1.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.stats >> ${mergeFileList1}.GetperFullBampostQCStats.vs3.${date1}.output"
#		cat $mainDir2/$baseFile1.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.stats >> ${mergeFileList1}.GetperFullBampostQCStats.vs3.ForP2.${date1}.output 	
		cat $mainDir2/$baseFile1.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.stats >> ${mergeFileList1}.GetperFullBampostQCStats.vs3.ForP2.sdfsfsfsf.output 	


	fi

done

