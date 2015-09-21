#!/bin/sh

#mainDir1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/
#TrueFake Ex: TruePheno 
#Pheno1 Ex: HIVPROG 
#Subset1 Ex: Exonic.Nonsynonymous

Groupf="$2"
Pheno1="$3"

mainDir1="$1"
TrueFake1="$2"
Pheno1="$3"
Subset1="$4"
Begin1="$5"
End1="$6"

mainDirFull="${mainDir1}/${TrueFake1}/${Pheno1}/${Subset1}/"

for i in {1..100}
do
	if [ ! -d ${mainDir1}/${TrueFake1} ] ; then
		mkdir ${mainDir1}/${TrueFake1}
	fi
	
	if [ ! -d ${mainDir1}/${TrueFake1}/${Pheno1} ] ; then
		mkdir ${mainDir1}/${TrueFake1}/${Pheno1}
	fi
	
	if [ ! -d ${mainDir1}/${TrueFake1}/${Pheno1}/${Subset1} ] ; then
		mkdir ${mainDir1}/${TrueFake1}/${Pheno1}/${Subset1}
	fi
	
	if [ ! -d ${mainDirFull}/qsubout ] ; then
		mkdir ${mainDirFull}/qsubout
	fi
	
	qsubout="${mainDirFull}/qsubout/qsubout.GATK.EPACTSMultiRun.${Pheno1}.Run${i}.txt"
	qsubouttemp="${mainDirFull}/qsubout/qsubout.GATK.EPACTSMultiRun.${Pheno1}.Run${i}.txt_temp"
	qsuboutAll="${mainDirFull}/qsubout/qsubout.All.GATK.EPACTSMultiRun.${Pheno1}.Run${i}.txt"
	qsuboutAlltemp="${mainDirFull}/qsubout/qsubout.All.GATK.EPACTSMultiRun.${Pheno1}.Run${i}.txt_temp"

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
	
	cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/$TrueFake1/$Pheno1/$Subset1/*epacts | perl -slane 'my @vals1 = split(/_/, $F[3]); if ($vals1[1] =~ m/^$geneID$/) { print join("\t", @F); } ' -- -geneID=$gene  | awk '{ print $10 }' | perl -ane 'print $F[0], "\t";' | awk ' { print $0 }' | perl -sane 'chomp(@F); print $geneID, ":\t", join("\t", @F), "\n";' -- -geneID=$gene >> /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/$TrueFake1/$Pheno1/$Subset1/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs1.$TrueFake1.$Pheno1.$Subset1.output  
	

#	Groupf, Pheno1, perm1

	qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v Groupf=$Groupf,Pheno1=$Pheno1,Run1=$i /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/DataAnalysis.GATK.EPACTSMultiRun.vs2.sh 

#	qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainDirFull=$mainDirFull,baseFileN=$baseFile1,I=$i,refFileFlag1=$refFileFlag1 DataProcessing.Pipeline.pt6.GATK.ptb.CreateVCFfilesPerChromosome.vs1.sh 

#	sleep 1

done
