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

#array1 Ex: MM5
#mainDir1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/
#File1 Ex: AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs
#TrueFake Ex: TruePheno
#Pheno Ex: Pheno3 
#Subset Ex: Exonic.Nonsynonymous

array1="$1"
mainDir1="$2"
File1="$3"
TrueFake="$4"
Pheno="$5"
Subset="$6"
Dir2File2="/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs3.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.vs3.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice"
#Dir2File2=""

#AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno4.maf1.skat0.run1.epacts

##
##Moving and removing files
##

mv $mainDir1/$File1*$Subset*$Pheno*run* $mainDir1/$TrueFake/$Pheno/$Subset/.

rm $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.OK $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*cov $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*phe $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*Makefile $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*ind $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.R $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.conf $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.top5000

#: << 'END'

##
##Getting PValsperGene
##

####cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts | perl -lane 'my @vals1 = split(/_/, $F[3]); print $vals1[1];' > $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList
cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts | perl -lane 'my @vals1 = split(/_/, $F[3]); print join("_", @vals1[1..$#vals1]);' > $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList

bash /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.sh $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList $mainDir1 $File1 $TrueFake $Pheno $Subset

cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output | grep -wv NA > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs

####cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs | /home/shared/software/R-3.0.1/bin/R -q -e "Data1 <- read.table(file('stdin'), header=T, row.names=1); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd))); jpeg(\"$mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.jpg\", width=2500, height=2000, res=300); print(Data1[14,]); par(mfrow=c(2,2)); hist(as.numeric(Data1[40,])); hist(as.numeric(Data1[156,])); hist(as.numeric(Data1[261,])); hist(as.numeric(Data1[345,])); dev.off();" > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput
cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs | /home/shared/software/R-3.0.1/bin/R -q -e "library(qvalue, lib=\"/home/michaelt/Software/R-3.0.1/library\"); Data1 <- read.table(file('stdin'), header=T, row.names=1); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd), signif(qvalue(apply(Data1,1,mean))\$qvalues, 5))); jpeg(\"$mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.histograms.jpeg\", width=2500, height=2000, res=300); par(mfrow=c(2,2)); hist(as.numeric(Data1[40,])); hist(as.numeric(Data1[121,])); hist(as.numeric(Data1[198,])); hist(as.numeric(Data1[271,])); dev.off();" | grep -v ^\> | sort -rg -k 2,2 | head -n -3 > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput

rm -f $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts

for gene1 in `cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList`
do
#	if P2 or something here
####	paste <(cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | grep $gene1) <(cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs3.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice | grep $gene1 | perl -lane 'print $#F;') >> $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts
####	paste <(cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | grep $gene1) <(cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/EPACTSFiles/AllPools.P2.Vs2.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice | grep $gene1 | perl -lane 'print $#F;') >> $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts
	paste <(cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | grep $gene1) <(cat $Dir2File2 | grep $gene1 | perl -lane 'print $#F;') >> $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts
#	echo $gene1 | paste - <(cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | grep $gene1) <(cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs3.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice | grep $gene1 | perl -lane 'print $#F;') >> $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts

done


cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | R -q -e "Data1 <- read.table(file('stdin'), header=F); write.table(matrix(c(as.character(Data1[,1]), -log10(Data1[,2])), ncol=2), quote=FALSE, row.name=FALSE, col.name=FALSE, sep=\"\t\")" | grep -v ^\> > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.rnk

python /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptg.HomeCodeSUMSTAT.Analysis.vs1.py --file1 $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.rnk --file2 /home/michaelt/Data/GSEA/c2.all.v4.0.symbols.gmt > $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.rnk.SUMSTAT

#END


-rw-rw-r-- 1 michaelt pg    3011 Feb 18  2015 OLD4.AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno2.maf1.skat0.run1.epacts.GeneIDList
-rw-rw-r-- 1 michaelt pg  362094 Feb 18  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output
-rw-rw-r-- 1 michaelt pg  356873 Feb 18  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs
-rw-rw-r-- 1 michaelt pg  243058 Feb 18  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.jpg
-rw-rw-r-- 1 michaelt pg   19484 Feb 18  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs1.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.Routput.GetFDRValsPerGeneFromPermutations.vs1.output
-rw-rw-r-- 1 michaelt pg   24702 Feb 18  2015 OLD4.WRONG1.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.Routput.wVarCounts
-rw-rw-r-- 1 michaelt pg  291823 Feb 26  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.Routput.QQPlotUsingPermutations.vs1.jpeg
-rw-rw-r-- 1 michaelt pg    4061 Mar  2  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.Routput.PerRankCmSum
-rw-rw-r-- 1 michaelt pg   25876 Mar  2  2015 OLD4.DataProcessing.Pipeline.Utility.TrueVsFakePerRankCmSum.vs1.TruePheno.Pheno2.Exonic.Nonsynonymous.output
-rw-rw-r-- 1 michaelt pg  242708 Mar 10  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.histograms.jpeg
-rw-rw-r-- 1 michaelt pg  229186 Mar 10  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.obspValHist.jpeg
-rw-rw-r-- 1 michaelt pg   22926 Mar 10  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.Routput
-rw-rw-r-- 1 michaelt pg   94364 Mar 11  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.Routput.wVarCounts
-rw-rw-r-- 1 michaelt pg    5954 Mar 11  2015 OLD4.DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno2.Exonic.Nonsynonymous.output.noNAs.Routput.wVarCounts.justpVals
-rw-rw-r-- 1 michaelt pg 1420819 Sep 16 15:36 OLD4.AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno2.maf1.skat0.runAll.Files.tar.gz


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
