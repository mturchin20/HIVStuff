#!/bin/sh

#######
#
#	Description
#	
#######

beginTime1=`perl -e 'print time;'`
date1=`date`
#PBSnodeFile=`cat $PBS_NODEFILE`
#PBSnodeFile=`cat $PBS_NODEFILE`

#Groupf Ex: Exonic.Nonsynonymous
#Pheno1 Ex: HIVPROG 
#PermTot Ex: 1000
#cutoff Ex: 100

Groupf="$1"
Pheno1="$2"
PermTot="$3"
cutoff="$4"

rm /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.CummPvalComp.vs1.${Groupf}.${Pheno1}.top${cutoff}.results

#Loop for going through each permutation
#$(eval echo {$START1..$END1})
for i in $(eval echo {1..$PermTot});
do

	cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.${Groupf}.${Pheno1}.maf1.skat0.perm${i}.epacts | sort -rg -k 10,10 | grep -v NA | grep -v CHROM | awk '{ print $10 }' | tail -n $cutoff | \
	R -q -e "Data1 <- read.table(file('stdin'), header=FALSE); print(sum(Data1[,1]));" | perl -lane 'if ($F[0] !~ /^\>/) { print join("\t", @F); } ' | awk '{ print $2 }' >> /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.CummPvalComp.vs1.${Groupf}.${Pheno1}.top${cutoff}.results

done


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
