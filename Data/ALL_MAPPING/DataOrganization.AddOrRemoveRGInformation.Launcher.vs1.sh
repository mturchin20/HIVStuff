#!/bin/sh

#Example: DataOrganization.CollectAllIndvMIDRLsffFiles.Thu_May_16_14:54:21_CDT_2013.output
RLMIDsffFile="$1"
#mergeFlag="$2"

OLD_IFS=$IFS
IFS=$'\n'

for DirAndsffFile in `cat $RLMIDsffFile`
do
	
	FLAG1=`echo $DirAndsffFile | perl -lane 'if ($F[0] =~ m/\#/) { print "1"; } else { print "0"; }'`
	
	if [ $FLAG1 == 1 ] ; then
		echo "Skip $DirAndsffFile"
	elif [ $FLAG1 == 0 ] ; then

#		echo $DirAndsffFile

		IFS=$OLD_IFS

		mainDir=`echo $DirAndsffFile | awk '{ print $1 }'`
#		sffFile=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/(.*)\.sff/) { print $1; }'`
		baseFile=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/(.*)\.sff/) { print $1; }'`

#		if [ $mergeFlag == "1" ] ; then
#			baseFile=`echo $DirAndsffFile | awk '{ print $2 }' | perl -lane 'if ($F[0] =~ m/
#		fi
		

		if [ ! -d ${mainDir}/qsubout ] ; then
			mkdir ${mainDir}/qsubout
		fi
			
		qsubout="${mainDir}/qsubout/qsubout.${baseFile}.txt"
		qsubouttemp="${mainDir}/qsubout/qsubout.${baseFile}.txt_temp"
		qsuboutAll="${mainDir}/qsubout/qsubout.All.${baseFile}.txt"
		qsuboutAlltemp="${mainDir}/qsubout/qsubout.All.${baseFile}.txt_temp"

		if [ -e $qsubout ] ; then
			if [ -e $qsuboutAll ] ; then
				appendCheckValue=`cat $qsuboutAll | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'` #Check the -F_ thing works out before going on/ahead with future design of this
				
				echo $appendCheckValue | cat $qsuboutAll - $qsubout > $qsuboutAlltemp
				mv $qsuboutAlltemp $qsuboutAll
			else 
				echo "Append_1" | cat - $qsubout > $qsuboutAll
			fi
		fi

#		echo $qsubout

#		mainDir baseFile

#		qsub -j oe -o $qsubout -e $qsubout -l walltime=72:00:00,mem=6gb,nodes=1:ppn=1 -v mergeFlag1=$mergeFlag,mainDir1=$mainDir,baseFile1=$baseFile,refFileFlag1=$refFileFlag DataProcessing.Pipeline.pt2.ProcessQCedfastqFiles.vs1.sh 
		qsub -j oe -o $qsubout -e $qsubout -l walltime=72:00:00,mem=6gb,nodes=1:ppn=1 -v mainDir1=$mainDir,baseFile1=$baseFile DataOrganization.AddOrRemoveRGInformation.vs1.sh 

#		sleep 1

	else 
		echo "Error1a -- \$FLAG1 neither 0 or 1 ($FLAG1)"
	fi
done
