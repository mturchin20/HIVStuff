#!/bin/sh

#Example: DataOrganization.CreatebamMergeList.vs1.20130909_231450.output 
mergeFileList1="$1"

OLD_IFS="$IFS" 
IFS=$'\n'

for fileDirList in `cat $mergeFileList1`
do
	
	IFS=$OLD_IFS
	
	#/home/pg/michaelt/Data/ALL_MAPPING/Pools/PreMerge/MM5/mapping_pool_106-124/POOL106-01RL,H9Y2FG202.RL1.sff
	mainDir1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); print $vals1[0];'`
	baseFile1=`echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/\|/, $F[0]); if ($vals1[1] =~ m/(.*)\.sff/) { print $1; };'`

#	echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/,/, $F[0]); print $vals1[0], "\n";'
#	echo $fileDirList | perl -F/\;/ -ane 'my @vals1 = split(/,/, $F[0]); if ($vals1[1] =~ m/(.*)\.sff/) { print $1; };'

#	echo $mainDir1
#	echo $baseFile1

	DirLvl1=`echo $mainDir1 | perl -F/ -ane '$F[8] = "PostMerge"; print "/", join("/", @F[1..9]);'`
	DirLvl2=`echo $mainDir1 | perl -F/ -ane '$F[8] = "PostMerge"; if ($F[10] =~ m/(POOL\w+).*(\d\dRL)/) { $F[10] = $1 . "_" . $2;  print "/", join("/", @F[1..10]);}'`

	if [ ! -d $DirLvl1 ] ; then
		mkdir $DirLvl1
	fi
	
	if [ ! -d $DirLvl2 ] ; then
		mkdir $DirLvl2
	fi

	if [ ! -d ${DirLvl2}/qsubout ] ; then
		mkdir ${DirLvl2}/qsubout
	fi
	
	qsubout="${DirLvl2}/qsubout/qsubout.${baseFile1}.txt"
	qsubouttemp="${DirLvl2}/qsubout/qsubout.${baseFile1}.txt_temp"
	qsuboutAll="${DirLvl2}/qsubout/qsubout.All.${baseFile1}.txt"
	qsuboutAlltemp="${DirLvl2}/qsubout/qsubout.All.${baseFile1}.txt_temp"

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

#	mainDir

#	echo $fileDirList

	qsub -j oe -o $qsubout -e $qsubout -l walltime=72:00:00,mem=6gb,nodes=1:ppn=6 -v fileDirList1=$fileDirList DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.vs4.sh 
#	qsub -j oe -o $qsubout -e $qsubout -l walltime=72:00:00,mem=6gb,nodes=1:ppn=1 -v fileDirList1=$test1 DataProcessing.Pipeline.pt3.MergeallSampleBamFiles.vs1.sh 

#	sleep 1

done
