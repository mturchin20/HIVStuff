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

rm /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.DirectLociPvalComp.vs1.${Groupf}.${Pheno1}.results

#Loop for each locus
for gene in `cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno1.maf1.skat0.epacts.justGeneIDs`;
do
	
#	echo "here1"

	cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.${Groupf}.${Pheno1}.maf1.skat0.*epacts | grep $gene | awk '{ print $10 }' > /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.DirectLociPvalComp.vs1.${Groupf}.${Pheno1}.tmp1

#	echo "here2"

	pval1=`cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.${Groupf}.${Pheno1}.maf1.skat0.epacts | grep $gene | awk '{ print $10 }'`

#	echo "here3"

	permCount=`cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.DirectLociPvalComp.vs1.${Groupf}.${Pheno1}.tmp1 | awk -v pval=$pval1 'BEGIN{count1=0;} {if ($1 <= pval) { count1++ }} END {print count1}'`

#	echo $gene $pval1 $permCount

	echo $gene $pval1 $permCount >> /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.DirectLociPvalComp.vs1.${Groupf}.${Pheno1}.results

done


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
