#!/bin/sh

#mainDir1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/FileChunks/
#File1 Ex: DataOrganization.CollectAllIndvMIDRLsffFiles.vs3.WorkingMainFile.Edited.output

mainDir1="$1"
File1="$2"
File1a=`echo $File1 | perl -ane 'my @vals1 = split(/\./, $F[0]); print join(".", (@vals1[0..($#vals1-1)]));'`
File1b=`echo $File1 | perl -ane 'my @vals1 = split(/\./, $F[0]); print $vals1[$#vals1];'`

echo $File1a $File1b 

#: <<'END'

for i in {2..37}
do

	File2="${File1a}.chunk${i}.${File1b}"

	echo $File2

	if [ ! -d ${mainDir1}/qsubout ] ; then
		mkdir ${mainDir1}/qsubout
	fi
	
	qsubout="${mainDir1}/qsubout/qsubout.${File2}.txt"
	qsubouttemp="${mainDir1}/qsubout/qsubout.${File2}.txt_temp"
	qsuboutAll="${mainDir1}/qsubout/qsubout.All.${File2}.txt"
	qsuboutAlltemp="${mainDir1}/qsubout/qsubout.All.${File2}.txt_temp"

	if [ -e $qsubout ] ; then
		if [ -e $qsuboutAll ] ; then
			appendCheckValue=`cat $qsuboutAll | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'` #Check the -F_ thing works out before going on/ahead with future design of this
			
			echo $appendCheckValue | cat $qsuboutAll - $qsubout > $qsuboutAlltemp
			mv $qsuboutAlltemp $qsuboutAll
		else 
			echo "Append_1" | cat - $qsubout > $qsuboutAll
		fi
	fi

	qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainDir1=$mainDir1,File1=$File2 /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.fastQCgroupOfFiles.vs1.sh

	sleep 1

done
#END
