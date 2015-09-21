cmd_args = commandArgs()

#Data1 Ex: 
#Data2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/FakePheno/Pheno1/Exonic.Nonsynonymous/AllPools.Vs3.ChrAll.GATK.RRs.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHM3.justWhite.QCed.DropIBD.indv80.EPACTS.RMID5PCs.Exonic.Nonsynonymous.Pheno1.maf1.skat0.permAll.epacts.PerRankCmSum

Data1 <- read.table(cmd_args[5], header=FALSE)
Data2 <- read.table(cmd_args[6], header=FALSE)

FinalOutput1 <- c()

for (i in 1:nrow(Data1)) {
#for (i in 1:50) {

	FinalOutput1 <- rbind(FinalOutput1, c(i, Data1[i,1], length(Data2[i,Data2[i,] > Data1[i,1]])/ncol(Data2), max(Data2[i,]), mean(as.numeric(Data2[i,])), sd(Data2[i,])))

}

#colnames(FinalOutput1) <- c("Gene", "p-Value", "#_True_Hits", "#_Fake_Hits", "FDR")
colnames(FinalOutput1) <- c("Rank", "CmSum_-log10(pVal)", "permutation_p-Val", "permutation_Max", "permutation_Mean", "permutation_SD")

write.table(FinalOutput1, file="", quote=FALSE, row.names=FALSE)

warnings()
