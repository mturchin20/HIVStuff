cmd_args = commandArgs()
Data1 <- read.table(cmd_args[5], header=TRUE) #Data1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.Pheno1.10PCsmaf01geno05.Assoc.assoc.logistic

#Data1lowmiss <- Data1[Data1[,6]>100,]
#Data1lowmiss <- Data1lowmiss[order(Data1lowmiss[,9]),]

#Data1subset <- Data1[Data1[,6] > 100 & Data1[,5] == "ADD" & !is.na(Data1[,9]),]
Data1subset <- Data1[Data1[,5] == "ADD" & !is.na(Data1[,9]),]
Data1subset <- Data1subset[order(Data1subset[,9]),]


xVals1 <- seq(1/nrow(Data1subset),1,by=1/nrow(Data1subset))

jpeg(file=cmd_args[7], height=2000, width=2500, res=300)

plot(-1*log10(xVals1), -1*log10(Data1subset[,9]), xlab="-log10 Expected p-Values", ylab="-log10 Observed p-Values", main=cmd_args[6])
abline(a=0, b=1)

dev.off()
