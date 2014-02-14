#!/bin/sh

#RLMIDsffFIle Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs2.20130828_141053.output

RLMIDsffFile="$1"

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

		if [ ! -d ${mainDir}/qsubout ] ; then
			mkdir ${mainDir}/qsubout
		fi
#: <<'END'
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
#END
#		echo $qsubout
#		totalDir sffFile1

		qsub -j oe -o $qsubout -e $qsubout -l walltime=10:00:00,mem=6gb,nodes=1:ppn=4 -v totalDir=$mainDir,baseFile1=$baseFile DataProcessing.Pipeline.pt1.ConvrtsffFilestoFastq.vs2.sh 
#		qsub -o $qsubout1 -e $qsubout2 -l walltime=10:00:00,mem=1gb,nodes=1:ppn=1 -v totalDir=$mainDir,baseFile1=$baseFile DataProcessing.ConvrtsffFilestoFastq.sh 

#		sleep 1
	
	else
		echo "Error1a -- \$FLAG1 neither 0 or 1 ($FLAG1)"
	fi

done
