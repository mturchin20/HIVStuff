#!/bin/sh

#Example: DataOrganization.CreatebamMergeList.vs1.20130909_231450.output 
mergeFileList1="$1"

OLD_IFS="$IFS" 
IFS=$'\n'

for fileDirList in `cat $mergeFileList1`
do
	
	IFS=$OLD_IFS
	
	FLAG1=`echo $fileDirList | perl -lane 'if ($F[0] =~ m/\#/) { print "1"; } else { print "0"; }'`
	
	if [ $FLAG1 == 1 ] ; then
		echo "Skip $fileDirList"
	elif [ $FLAG1 == 0 ] ; then
	
		#/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PreMerge/mapping_pool_106-124/POOL106-08RL
		#/home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PreMerge/mapping_pool_106-124/POOL106-01RL|H9Y2FG202.RL1.sff
		mainDir1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); print $vals1[0];'`
#		baseFile1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); if ($vals1[1] =~ m/(.*)\.sff/) { print $1; };'`
		baseFile1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); my @vals2 = split(/\//, $vals1[0]); if ($vals2[11] =~ m/(POOL\w+).*(\d\dRL)/) { print $1, "_", $2; } '`

#		echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/,/, $F[0]); print $vals1[0], "\n";'
#		echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/,/, $F[0]); if ($vals1[1] =~ m/(.*)\.sff/) { print $1; };'

#		echo $mainDir1
#		echo $baseFile1
		
		DirLvl1=`echo $mainDir1 | perl -F/ -lane '$F[9] = "PostMerge"; print "/", join("/", @F[1..10]);'`
		DirLvl2=`echo $mainDir1 | perl -F/ -lane '$F[9] = "PostMerge"; if ($F[11] =~ m/(POOL\w+).*(\d\dRL)/) { $F[11] = $1 . "_" . $2;  print "/", join("/", @F[1..11]);}'`
		mainDir2=$DirLvl2

		if [ ! -d $DirLvl1 ] ; then
			mkdir $DirLvl1
		fi
		
		if [ ! -d $DirLvl2 ] ; then
			mkdir $DirLvl2
		fi

		if [ ! -d ${mainDir2}/qsubout ] ; then
			mkdir ${mainDir2}/qsubout
		fi
		
		if [ ! -d ${mainDir2}/P2Subsample ] ; then
			mkdir ${mainDir2}/P2Subsample
		fi
		
		qsubout="${mainDir2}/qsubout/qsubout.P2Subsample.${baseFile1}.txt"
		qsubouttemp="${mainDir2}/qsubout/qsubout.P2Subsample.${baseFile1}.txt_temp"
		qsuboutAll="${mainDir2}/qsubout/qsubout.All.P2Subsample.${baseFile1}.txt"
		qsuboutAlltemp="${mainDir2}/qsubout/qsubout.All.P2Subsample.${baseFile1}.txt_temp"

		if [ -e $qsubout ] ; then
			if [ -e $qsuboutAll ] ; then
				appendCheckValue=`cat $qsuboutAll | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
				
				echo $appendCheckValue | cat $qsuboutAll - $qsubout > $qsuboutAlltemp
				mv $qsuboutAlltemp $qsuboutAll
			else 
				echo "Append_1" | cat - $qsubout > $qsuboutAll
			fi
		fi

		echo $qsubout
		
		refFileFlag1=`perl -e 'my $val1 = int(rand(9)); print $val1;'`

#		mainDir2, baseFile1, refFileFlag1

#		qsub -j oe -o $qsubout -e $qsubout -l walltime=72:00:00,mem=6gb,nodes=1:ppn=32 -v mainDir1=$mainDir2,baseFileN=$baseFile1,refFileFlag1=$refFileFlag1 DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.vs1.sh 
		qsub -j oe -o $qsubout -e $qsubout -l walltime=72:00:00,mem=6gb,nodes=1:ppn=6 -v mainDir1=$mainDir2,baseFileN=$baseFile1,refFileFlag1=$refFileFlag1 /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt4.ProcessSampleLvlbamFiles.vs2.P2Subsample.vs1.sh 

#		sleep 1
	
	fi

done
