#!/bin/sh

########
#
# Date:
# Description:
#
# Code (c) Michael Turchin 201*
#
########

beginTime1=`perl -e 'print time;'`
date1=`date`

#mainDir1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/
#File1 Ex: AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs
#TrueFake Ex: TruePheno
#Pheno Ex: Pheno3 
#Subset Ex: Exonic.Nonsynonymous
#oldNum Ex: OLD3

Array1="$1"
mainDir1="$2"
File1="$3"
TrueFake="$4"
Pheno="$5"
Subset="$6"
oldNum="$7"

#AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno4.maf1.skat0.perm1.epacts

mv $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm1.epacts.GeneIDList $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.${File1}.${Subset}.${Pheno}.maf1.skat0.perm1.epacts.GeneIDList
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.histograms.jpg $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.histograms.jpg
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput

mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput.GetFDRValsPerGeneFromPermutations.vs1.output $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput.GetFDRValsPerGeneFromPermutations.vs1.output
mv $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.SUMSTAT.vs1.${TrueFake}.${Pheno}.${Subset}.output $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.SUMSTAT.vs1.${TrueFake}.${Pheno}.${Subset}.output

if [ ! -e $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.${File1}.${Subset}.${Pheno}.maf1.skat0.permAll.Files.tar.gz ] ; then 
	tar -cvzf $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.${File1}.${Subset}.${Pheno}.maf1.skat0.permAll.Files.tar.gz $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm*.epacts
	PH=1
fi
#rm $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm*.epacts
#rm $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm*.epacts.rnk
#rm -r $mainDir1/$TrueFake/$Pheno/$Subset/GSEA/DataProcessing.Pipeline.pt6.All.ptg.GSEA.PermutationPrerankAnalyses.vs1.EPACTS.${Subset}.${Pheno}.maf1.skat0.perm*.GSEA.GseaPreranked
#rm $mainDir1/$TrueFake/$Pheno/$Subset/GSEA/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.GSEA.vs1.${TrueFake}.${Pheno}.${Subset}.output $mainDir1/$TrueFake/$Pheno/$Subset/GSEA/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.GSEA.vs1.${TrueFake}.${Pheno}.${Subset}.gsea_report_for_na_pos_All.xls.temp
#rm $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.pt6.All.ptg.HomeCodeSUMSTAT.Analysis.vs1.EPACTS.${TrueFake}.${Subset}.${Pheno}.maf1.skat0.perm*.GSEA.rnk.SUMSTAT*


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
