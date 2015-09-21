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

mainDir1="$1"
File1="$2"
TrueFake="$3"
Pheno="$4"
Subset="$5"
oldNum="$6"

#AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno4.maf1.skat0.run1.epacts

mv $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.jpg $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.jpg
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.histograms.jpeg $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.histograms.jpeg
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs1.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.GetFDRValsPerGeneFromPermutations.vs1.output $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs1.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.GetFDRValsPerGeneFromPermutations.vs1.output
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.QQPlotUsingPermutations.vs1.jpeg $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.QQPlotUsingPermutations.vs1.jpeg
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.PerRankCmSum $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.PerRankCmSum
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.TrueVsFakePerRankCmSum.vs1.$TrueFake.$Pheno.Exonic.Nonsynonymous.output $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.TrueVsFakePerRankCmSum.vs1.$TrueFake.$Pheno.Exonic.Nonsynonymous.output
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.obspValHist.jpeg $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.obspValHist.jpeg
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.wVarCounts $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.wVarCounts
mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.wVarCounts.justpVals $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.Exonic.Nonsynonymous.output.noNAs.Routput.wVarCounts.justpVals



mv $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput.GetFDRValsPerGeneFromPermutations.vs1.output $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput.GetFDRValsPerGeneFromPermutations.vs1.output
mv $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.SUMSTAT.CalcPermBasedPVal.vs1.${TrueFake}.${Pheno}.${Subset}.output $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/${oldNum}.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.SUMSTAT.CalcPermBasedPVal.vs1.${TrueFake}.${Pheno}.${Subset}.output

if [ ! -e $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.${File1}.${Subset}.${Pheno}.maf1.skat0.runAll.Files.tar.gz ] ; then 
	tar -cvzf $mainDir1/$TrueFake/$Pheno/$Subset/${oldNum}.${File1}.${Subset}.${Pheno}.maf1.skat0.runAll.Files.tar.gz $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run*.epacts
	PH=1
fi
rm $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run*.epacts
rm $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput.rnk
rm $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput.rnk.SUMSTAT

endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""






