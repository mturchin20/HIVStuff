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

Groupf="$1"
Pheno1="$2"
PermTot="$3"


#Loop for each locus
for gene in `cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno1.maf1.skat0.epacts.justGeneIDs`;
do

#	echo $gene

	rm /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/perGeneCollect/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.DirectLociPvalComp.vs1.${Groupf}.${Pheno1}.${gene}.txt

	#Loop for going through each permutation
	#$(eval echo {$START1..$END1})
	for i in $(eval echo {1..$PermTot});
	do

		cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.${Groupf}.${Pheno1}.maf1.skat0.perm${i}.epacts | grep $gene >> /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/perGeneCollect/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.DirectLociPvalComp.vs1.${Groupf}.${Pheno1}.${gene}.txt

	done

done


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
