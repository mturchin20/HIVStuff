cmd_args = commandArgs()

#Data1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/TruePheno/Pheno1/Exonic.Nonsynonymous/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs1.TruePheno.Pheno1.Exonic.Nonsynonymous.output.noNAs.Routput
#Data2 Ex: <(cat /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/FakePheno/Pheno1/Exonic.Nonsynonymous/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.EPACTS.Exonic.Nonsynonymous.Pheno1.maf1.skat0.perm*.epacts | awk '{ print $10 }' | grep -v -E 'NA|PVALUE' | sort -rg -k 1,1)

Data1 <- read.table(cmd_args[5], header=FALSE)
Data2 <- read.table(cmd_args[6], header=FALSE)

Data1[,2] <- as.numeric(Data1[,2])

Count1 <- 0

FinalOutput1 <- c()

#for (i in nrow(Data1):(nrow(Data1)-50)) {
for (i in nrow(Data1):1) {

	Count1 <- Count1 + 1

	NumPermHits <- length(Data2[Data2[,1] <= Data1[i,2],1])

#	FDR <- (Count1 / (NumPermHits/1000)) * 100
	FDR <- ((NumPermHits/1000) / Count1) * 100

#	write.table(matrix(c(as.character(Data1[i,1]), Data1[i,2], Count1, FDR, NumPermHits), nrow=1), file="")

#	FinalOutput1 <- rbind(FinalOutput1, c(as.character(Data1[i,1]), Data1[i,2], Count1, FDR, NumPermHits))
	FinalOutput1 <- rbind(FinalOutput1, c(as.character(Data1[i,1]), Data1[i,2], Count1, NumPermHits, FDR))

}

colnames(FinalOutput1) <- c("Gene", "p-Value", "#_True_Hits", "#_Fake_Hits", "FDR")

write.table(FinalOutput1, file="", quote=FALSE, row.names=FALSE)

