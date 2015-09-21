cmd_args = commandArgs()
Data1 <- read.table(cmd_args[5], header=TRUE) #Data1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.whiteOnly.5PCs.assoc.logistic.wAC.gz

Data1subset <- Data1[Data1[,5] == "ADD" & !is.na(Data1[,9]),]
Data1subset <- Data1subset[order(Data1subset[,9]),]

jpeg(file=cmd_args[6], height=2000, width=2500, res=300)

plot(jitter(Data1subset[,13]/(Data1subset[,6]*2), factor=2), -1*log10(Data1subset[,9]), xlim=c(0,.01), xlab="Other Allele Count", ylab="-log10 p-Values", main="Other Allele Count vs. -log10 p-Values")
#abline(a=0, b=1, lwd=2, lty=3, col="RED")

dev.off()
