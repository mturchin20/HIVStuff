#!/bin/sh

#Example: DataOrganization.CollectAllIndvMIDRLsffFiles.Thu_May_16_14:54:21_CDT_2013.output
POOLIDFile="$1"
DirectoryPOOLIDFile="$2"
#RLMIDsffFile="$1"

MergeListbam=""
MergeListbai=""

for POOLID in `cat $POOLIDFile`
do
	
	MergeListbam=""
	MergeListbai=""
	
	cat $DirectoryPOOLIDFile | grep $POOLID > DataProcessing.Pipeline.pt3.MergeandProcessSampleLvlbamFiles.Launcher.tempfile

	OLD_IFS=$IFS
	IFS=$'\n'
	
	for DirectoryPOOLIDsubset in `cat DataProcessing.Pipeline.pt3.MergeandProcessSampleLvlbamFiles.Launcher.tempfile`
	do
	
		IFS=$OLD_IFS

		mainDir1=`echo $DirectoryPOOLIDsubset | awk '{ print $1 }'`

		MergeListbamtmp=`ls -lrt ${mainDir1}/. | grep preGATK.bam | perl -sane 'print $mainDir, "/", $F[8], "\t";' -- -mainDir=$mainDir1` #Make sure grep identifier stays up to date
		MergeListbaitmp=`ls -lrt ${mainDir1}/. | grep preGATK.bai | perl -sane 'print $mainDir, "/", $F[8], "\t";' -- -mainDir=$mainDir1` #Make sure grep identifier stays up to date

		MergeListbam="${MergeListbam} ${MergeListbamtmp}"
		MergeListbai="${MergeListbai} ${MergeListbaitmp}"

	done

	mainDir2="/home/pg/michaelt/Data/SampleData/SampleDirectories/${POOLID}"

	if [ ! -d $mainDir2 ] ; then
		mkdir $mainDir2
	fi

	if [ ! -d ${mainDir2}/qsubout ] ; then
		mkdir ${mainDir2}/qsubout
	fi
		
	qsubout="${mainDir2}/qsubout/qsubout.${POOLID}.txt"
	qsubouttemp="${mainDir2}/qsubout/qsubout.${POOLID}.txt_temp"
	qsuboutAll="${mainDir2}/qsubout/qsubout.All.${POOLID}.txt"
	qsuboutAlltemp="${mainDir2}/qsubout/qsubout.All.${POOLID}.txt_temp"

	if [ -e $qsubout ] ; then
		if [ -e $qsuboutAll ] ; then
			appendCheckValue=`cat $qsuboutAll | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
			
			echo $appendCheckValue | cat $qsuboutAll - $qsubout > $qsuboutAlltemp
			mv $qsuboutAlltemp $qsuboutAll
		else 
			echo "Append_1" | cat - $qsubout > $qsuboutAll
		fi
	fi

	echo $qsubout $MergeListbam $MergeListbai

	refFileFlag=`perl -e 'my $val1 = int(rand(9)); print $val1;'`

#	mainDir2 MergeList refFileFlag

#	qsub -j oe -o $qsubout -e $qsubout -l walltime=72:00:00,mem=6gb,nodes=1:ppn=1 -v mainDir1=$mainDir2,MergeListbam1=$MergeListbam,MergeListbai1=$MergeListbai,refFileFlag1=$refFileFlag DataProcessing.Pipeline.pt3.MergeandProcessSampleLvlbamFiles.sh 

#	sleep 1

done
