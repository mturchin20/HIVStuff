#!/bin/sh

#mainDir1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations
#Groupf Ex: Exonic.Nonsynonymous
#Pheno1 Ex: HIVPROG 

mainDir1="$1"
Groupf="$2"
Pheno1="$3"

for i in {101..1000}
do
	if [ ! -d ${mainDir1}/qsubout ] ; then
		mkdir ${mainDir1}/qsubout
	fi
	
	qsubout="${mainDir1}/qsubout/qsubout.GATK.PermutationEPACTSRun.${Pheno1}.Perm${i}.txt"
	qsubouttemp="${mainDir1}/qsubout/qsubout.GATK.PermutationEPACTSRun.${Pheno1}.Perm${i}.txt_temp"
	qsuboutAll="${mainDir1}/qsubout/qsubout.All.GATK.PermutationEPACTSRun.${Pheno1}.Perm${i}.txt"
	qsuboutAlltemp="${mainDir1}/qsubout/qsubout.All.GATK.PermutationEPACTSRun.${Pheno1}.Perm${i}.txt_temp"

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
	

#	Groupf, Pheno1, perm1

	qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v Groupf=$Groupf,Pheno1=$Pheno1,Perm1=$i /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/DataAnalysis.GATK.PermutationEPACTSRun.vs1.sh 

#	qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainDir1=$mainDir1,baseFileN=$baseFile1,I=$i,refFileFlag1=$refFileFlag1 DataProcessing.Pipeline.pt6.GATK.ptb.CreateVCFfilesPerChromosome.vs1.sh 

#	sleep 1

done
