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
#Dir2File2="/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs3.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.vs3.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice"
#Dir2File2="/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/EPACTSFiles/AllPools.P2.Vs2.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.vs2.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice"
###Dir2File2="/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/Analyses/XChrFollowup/AllPools.Vs3.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.XChr.wHM3.CEUCHBYRI.10PCs.justWhite.QCed.DropIBD.indv80.vs3.gt10Het.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice"
#Dir2File2="/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/Analyses/XChrFollowup/AllPools.Vs3.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.XChr.wHM3.CEUCHBYRI.10PCs.justWhite.QCed.DropIBD.indv80.vs3.gt10Het.AutoAndX.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice"
Dir2File2="/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/Analyses/XChrFollowup/AllPools.P2.Vs2.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.XChr.wHM3.CEUCHBYRI.10PCs.justWhite.QCed.DropIBD.indv80.vs2.gt10Het.AutoAndX.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice"

Rand1="$[1 + $[ $RANDOM % 100 ]]"
Rand2="$[1 + $[ $RANDOM % 100 ]]"
Rand3="$[1 + $[ $RANDOM % 100 ]]"
Rand4="$[1 + $[ $RANDOM % 100 ]]"
RandA="$[1 + $[ $RANDOM % 100 ]]"
RandB="$[1 + $[ $RANDOM % 100 ]]"
RandC="$[1 + $[ $RANDOM % 100 ]]"

echo "Random Numbers: $Rand1 $Rand2 $Rand3 $Rand4 | $RandA $RandB $RandC" > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.MultiRuns.MvAndProcessResults.vs3.$TrueFake.$Pheno.$Subset.output.RanNumbers

#AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno4.maf1.skat0.run1.epacts

##
##Moving and removing files
##

#mv $mainDir1/$File1*$Subset*$Pheno*run* $mainDir1/$TrueFake/$Pheno/$Subset/.

#rm $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.OK $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*cov $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*phe $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*Makefile $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*ind $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.R $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.conf $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.top5000

#: << 'END'

##
##Getting PValsperGene
##

####cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts | perl -lane 'my @vals1 = split(/_/, $F[3]); print $vals1[1];' > $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList
cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts | perl -lane 'my @vals1 = split(/_/, $F[3]); print join("_", @vals1[1..$#vals1]);' > $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList

bash /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.sh $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList $mainDir1 $File1 $TrueFake $Pheno $Subset


cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output | grep -wv NA > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs

####cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs | /home/shared/software/R-3.0.1/bin/R -q -e "Data1 <- read.table(file('stdin'), header=T, row.names=1); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd))); jpeg(\"$mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.jpg\", width=2500, height=2000, res=300); print(Data1[14,]); par(mfrow=c(2,2)); hist(as.numeric(Data1[40,])); hist(as.numeric(Data1[156,])); hist(as.numeric(Data1[261,])); hist(as.numeric(Data1[345,])); dev.off();" > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput
####cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs | /home/shared/software/R-3.0.1/bin/R -q -e "library(qvalue, lib=\"/home/michaelt/Software/R-3.0.1/library\"); Data1 <- read.table(file('stdin'), header=T, row.names=1); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd), signif(qvalue(apply(Data1,1,mean))\$qvalues, 5))); jpeg(\"$mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.histograms.jpeg\", width=2500, height=2000, res=300); par(mfrow=c(2,2)); hist(as.numeric(Data1[40,])); hist(as.numeric(Data1[121,])); hist(as.numeric(Data1[198,])); hist(as.numeric(Data1[271,])); dev.off();" | grep -v ^\> | sort -rg -k 2,2 | head -n -3 > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput
cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs | /home/shared/software/R-3.0.1/bin/R -q -e "library(qvalue, lib=\"/home/michaelt/Software/R-3.0.1/library\"); Data1 <- read.table(file('stdin'), header=T, row.names=1); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd), signif(qvalue(apply(Data1,1,mean))\$qvalues, 5))); jpeg(\"$mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.histograms.jpeg\", width=2500, height=2000, res=300); par(mfrow=c(2,2)); hist(as.numeric(Data1[$Rand1,]), breaks=50); hist(as.numeric(Data1[$Rand2,]), breaks=50); hist(as.numeric(Data1[$Rand3,]), breaks=50); hist(as.numeric(Data1[$Rand4,]), breaks=50); dev.off();" | grep -v ^\> | sort -rg -k 2,2 | head -n -3 > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput

cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | /home/shared/software/R-3.0.1/bin/R -q -e "Data1 <- read.table(file('stdin'), header=T, row.names=1); jpeg(\"$mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput.obspValHist.jpeg\", width=2000, height=1500, res=300); hist(Data1[,1], xlab=\"Observed p-Values\", main=\"$array1 skat-O $Pheno $Subset\", breaks=50); dev.off();"

rm -f $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts

for gene1 in `cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run1.epacts.GeneIDList`
do
#	if P2 or something here
####	paste <(cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | grep $gene1) <(cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs3.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice | grep $gene1 | perl -lane 'print $#F;') >> $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts
####	paste <(cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | grep $gene1) <(cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/P2/PostMerge/mapping_pool_merged/Vs1/GATK/EPACTSFiles/AllPools.P2.Vs2.AllPoolsMerged.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice | grep $gene1 | perl -lane 'print $#F;') >> $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts
	paste <(cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | grep ^$gene1[^-0-9a-zA-Z_]) <(cat $Dir2File2 | grep ^$gene1[^-0-9a-zA-Z_] | perl -lane 'print $#F;') <(cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run${RandA}.epacts | grep [^-0-9a-zA-Z]$gene1[^-0-9a-zA-Z_] | perl -lane 'print join("\t", @F[4..$#F]);') <(cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run${RandB}.epacts | grep [^-0-9a-zA-Z]$gene1[^-0-9a-zA-Z_] | perl -lane 'print join("\t", @F[4..$#F]);') <(cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.run${RandC}.epacts | grep [^-0-9a-zA-Z]$gene1[^-0-9a-zA-Z_] | perl -lane 'print join("\t", @F[4..$#F]);') >> $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts 
####	echo $gene1 | paste - <(cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | grep $gene1) <(cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs3.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.bim.wGeneIDs.GroupFile.Exonic.Nonsynonymous.wSplice | grep $gene1 | perl -lane 'print $#F;') >> $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts

done

cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts | awk '{ print $2 }' > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.wVarCounts.justpVals

cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | /home/shared/software/R-3.0.1/bin/R -q -e "Data1 <- read.table(file('stdin'), header=F); CmSum <- 0; for (i in nrow(Data1):1) { CmSum <- CmSum + qnorm(log(Data1[i,2]/2), lower.tail=FALSE, log.p=TRUE); print(CmSum); }" | head -n -3 | tail -n +2 > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.PerRankCmSum

cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput | R -q -e "Data1 <- read.table(file('stdin'), header=F); write.table(matrix(c(as.character(Data1[,1]), -log10(Data1[,2])), ncol=2), quote=FALSE, row.name=FALSE, col.name=FALSE, sep=\"\t\")" | grep -v ^\> > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.rnk

python /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptg.HomeCodeSUMSTAT.Analysis.vs1.py --file1 $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.rnk --file2 /home/michaelt/Data/GSEA/c2.all.v4.0.symbols.gmt > $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput.rnk.SUMSTAT

#END



endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
