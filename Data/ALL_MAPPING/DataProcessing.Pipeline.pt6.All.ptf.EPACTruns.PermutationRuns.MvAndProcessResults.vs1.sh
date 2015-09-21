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

mainDir1="$1"
File1="$2"
TrueFake="$3"
Pheno="$4"
Subset="$5"

#AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno4.maf1.skat0.run1.epacts

#: << 'END'

mv $mainDir1/$File1*$Subset*$Pheno*perm*epacts* $mainDir1/$TrueFake/$Pheno/$Subset/.
mv $mainDir1/$File1*$Subset*$Pheno*perm* $mainDir1/$TrueFake/$Pheno/$Subset/.

#rm $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.OK $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*cov $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*phe $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*Makefile $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*ind
#rm $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.R $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.conf $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*epacts.top5000

##cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm1.epacts | perl -lane 'my @vals1 = split(/_/, $F[3]); print $vals1[1];' > $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm1.epacts.GeneIDList
#cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm1.epacts | perl -lane 'my @vals1 = split(/_/, $F[3]); print join("_", @vals1[1..$#vals1]);' > $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm1.epacts.GeneIDList

#bash /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.sh $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm1.epacts.GeneIDList $mainDir1 $File1 $TrueFake $Pheno $Subset


#cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output | grep -wv NA > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs

#cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs | /home/shared/software/R-3.0.1/bin/R -q -e "Data1 <- read.table(file('stdin'), header=T, row.names=1); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd))); jpeg(\"$mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.histograms.jpg\", width=2500, height=2000, res=300); print(Data1[14,]); par(mfrow=c(2,2)); hist(as.numeric(Data1[40,])); hist(as.numeric(Data1[156,])); hist(as.numeric(Data1[261,])); hist(as.numeric(Data1[345,])); dev.off();" > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput
##cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs | /home/shared/software/R-3.0.1/bin/R -q -e "library(qvalue, lib=\"/home/michaelt/Software/R-3.0.1/library\"); Data1 <- read.table(file('stdin'), header=T, row.names=1); print(matrix(apply(Data1,1,mean))); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd), signif(qvalue(apply(Data1,1,mean))[\"qvalues\"], 5))); jpeg(\"$mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.jpg\", width=2500, height=2000, res=300); par(mfrow=c(2,2)); hist(as.numeric(Data1[40,])); hist(as.numeric(Data1[156,])); hist(as.numeric(Data1[261,])); hist(as.numeric(Data1[345,])); dev.off();" > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput

#bash /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.sh $mainDir1 $File1 $TrueFake $Pheno $Subset 1 1000

#Below command should not actually remove anything -- keeping it as sort of a sanity check thing
#cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output | grep -vw NA > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs

##cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs | R -q -e "Data1 <- read.table(file('stdin'), header=F); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd)));" | grep -v ^\> | tail -n +2 > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.$TrueFake.$Pheno.$Subset.output.noNAs.Routput
#cat $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs | R -q -e "library(qvalue); Data1 <- read.table(file('stdin'), header=F); print(cbind(apply(Data1,1,mean), apply(Data1,1,sd), signif(qvalue(apply(Data1,1,mean))\$qvalues, 5)));" | grep -v ^\> | tail -n +2 > $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput

/home/shared/software/R-3.0.1/bin/R --vanilla --slave --args < /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.Utility.QQPlotUsingPermutations.vs1.R $mainDir1/TruePheno/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.${Pheno}.${Subset}.output.noNAs.Routput $mainDir1/$TrueFake/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.${TrueFake}.${Pheno}.${Subset}.output.noNAs.Routput $mainDir1/TruePheno/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.${Pheno}.${Subset}.output.noNAs.Routput.QQPlotUsingPermutations.vs1.jpeg ${Pheno1}

: << 'END'

R --vanilla --slave --args < /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/DataProcessing.Pipeline.Utility.GetFDRValsPerGeneFromPermutations.vs1.R $mainDir1/TruePheno/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.${Pheno}.${Subset}.output.noNAs.Routput <(cat  $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.*perm*epacts | awk '{ print $10 }' | grep -v -E 'NA|PVALUE' | sort -rg -k 1,1) > $mainDir1/TruePheno/$Pheno/$Subset/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs1.TruePheno.${Pheno}.${Subset}.output.noNAs.Routput.GetFDRValsPerGeneFromPermutations.vs1.output

for i in {1..1000}
do
        echo $i
#	cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm${i}.epacts | awk '{ if ($10 != "NA") { print $0 } }' | perl -lane 'my @vals1 = split(/_/, $F[3]); $F[3] = $vals1[1]; print join("\t", @F);' | R -q -e "Data1 <- read.table(file('stdin'), header=F); write.table(matrix(c(as.character(Data1[,4]), -log10(Data1[,10])), ncol=2), quote=FALSE, row.name=FALSE, col.name=FALSE, sep=\"\t\")" | grep -v ^\> > $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm${i}.epacts.rnk 
	cat $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm${i}.epacts | awk '{ if ($10 != "NA") { print $0 } }' | perl -lane 'my @vals1 = split(/_/, $F[3]); $F[3] = join("_", @vals1[1..$#vals1]); print join("\t", @F);' | R -q -e "Data1 <- read.table(file('stdin'), header=F); write.table(matrix(c(as.character(Data1[,4]), -log10(Data1[,10])), ncol=2), quote=FALSE, row.name=FALSE, col.name=FALSE, sep=\"\t\")" | grep -v ^\> > $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm${i}.epacts.rnk 
done
for i in {1..1000}
do
        echo $i
	python /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptg.HomeCodeSUMSTAT.Analysis.vs1.py --file1 $mainDir1/$TrueFake/$Pheno/$Subset/${File1}.${Subset}.${Pheno}.maf1.skat0.perm${i}.epacts.rnk --file2 /home/michaelt/Data/GSEA/c2.all.v4.0.symbols.gmt > $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.pt6.All.ptg.HomeCodeSUMSTAT.Analysis.vs1.EPACTS.${TrueFake}.${Subset}.${Pheno}.maf1.skat0.perm${i}.rnk.SUMSTAT        
done

cat $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.pt6.All.ptg.HomeCodeSUMSTAT.Analysis.vs1.EPACTS.${TrueFake}.${Subset}.${Pheno}.maf1.skat0.perm*.rnk.SUMSTAT > $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.pt6.All.ptg.HomeCodeSUMSTAT.Analysis.vs1.EPACTS.${TrueFake}.${Subset}.${Pheno}.maf1.skat0.permAll.rnk.SUMSTAT.temp

python /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.SUMSTAT.vs1.py --file1 $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.pt6.All.ptg.HomeCodeSUMSTAT.Analysis.vs1.EPACTS.${TrueFake}.${Subset}.${Pheno}.maf1.skat0.permAll.rnk.SUMSTAT.temp > $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.SUMSTAT.vs1.${TrueFake}.${Pheno}.${Subset}.output 

R --vanilla --slave --args < /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.SUMSTAT.CalcPermBasedPVal.vs1.R  $mainDir1/TruePheno/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.${Pheno}.${Subset}.output.noNAs.Routput.rnk.SUMSTAT $mainDir1/$TrueFake/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.SUMSTAT.vs1.${TrueFake}.${Pheno}.${Subset}.output > $mainDir1/TruePheno/$Pheno/$Subset/SUMSTAT/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.SUMSTAT.CalcPermBasedPVal.vs1.TruePheno.${Pheno}.${Subset}.output

END


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
