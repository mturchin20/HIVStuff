#!/bin/sh

#mainDir1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/
#TrueFake Ex: FakePheno
#Pheno Ex: Pheno1
#Subset Ex: Exonic.Nonsynonymous

mainDir1="$1"
TrueFake="$2"
Pheno="$3"
Subset="$4"

mainDirFull="${mainDir1}/${TrueFake}/${Pheno}/${Subset}/"

for i in {1..1000}
#for i in {1..1}
do
	
	if [ ! -d ${mainDirFull}/qsubout ] ; then
		mkdir ${mainDirFull}/qsubout
	fi

	qsubout="${mainDirFull}/qsubout/qsubout.All.GSEA.PermutationPrerankAnalyses.Launcher.vs1.perm${i}.txt"
	qsubouttemp="${mainDirFull}/qsubout/qsubout.All.GSEA.PermutationPrerankAnalyses.Launcher.vs1.perm${i}.txt_temp"
	qsuboutAll="${mainDirFull}/qsubout/qsubout.All.GSEA.PermutationPrerankAnalyses.Launcher.vs1.perm${i}.txt"
	qsuboutAlltemp="${mainDirFull}/qsubout/qsubout.All.GSEA.PermutationPrerankAnalyses.Launcher.vs1.perm${i}.txt_temp"

	if [ -e $qsubout ] ; then
		if [ -e $qsuboutAll ] ; then
			appendCheckValue=`cat $qsuboutAll | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
			
			echo $appendCheckValue | cat $qsuboutAll - $qsubout > $qsuboutAlltemp
			mv $qsuboutAlltemp $qsuboutAll
		else 
			echo "Append_1" | cat - $qsubout > $qsuboutAll
		fi
	fi

	qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainDir1=$mainDirFull,TrueFake=$TrueFake,Pheno=$Pheno,Subset=$Subset,perm1=$i /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptg.GSEA.PermutationPrerankAnalyses.vs1.sh 

	sleep 1

done


