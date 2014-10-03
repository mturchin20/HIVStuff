#!/bin/sh

#mainDir1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged
#baseFile1 Ex: AllPools.preGATK.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged

mainDir1="$1"
baseFile1="$2"

for i in {1..22}
#for i in {X..X}
do
	if [ ! -d ${mainDir1}/qsubout ] ; then
		mkdir ${mainDir1}/qsubout
	fi
	
	qsubout="${mainDir1}/qsubout/qsubout.${baseFile1}.txt"
	qsubouttemp="${mainDir1}/qsubout/qsubout.${baseFile1}.txt_temp"
	qsuboutAll="${mainDir1}/qsubout/qsubout.All.${baseFile1}.txt"
	qsuboutAlltemp="${mainDir1}/qsubout/qsubout.All.${baseFile1}.txt_temp"

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

#	mainDir2, baseFile1, refFileFlag1

	qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainDir1=$mainDir1,baseFileN=$baseFile1,I=$i,refFileFlag1=$refFileFlag1 DataProcessing.Pipeline.pt6.All.pta.SplitBamIntoChromosomes.vs1.sh 

#	sleep 1

done
