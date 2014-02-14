cmd_args = commandArgs()
Data1 <- read.csv(cmd_args[5], header=FALSE) #Data1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz

jpeg(file=cmd_args[6], height=8000, width=3500, res=300)
par(mfrow=c(5,2))

SeroNegative <- density(Data1[,11])
HESeroNegative <- density(Data1[,12])
SeroPositive <- density(Data1[,13])
RapidVRapid <- density(Data1[,14])
SlowVSlow <- density(Data1[,15])

plot(SeroNegative, main="Sero-Negative")
#polygon(SeroNegative, col="RED")
plot(HESeroNegative, main="Highly Exposed Sero-Negative Only")
#polygon(HESeroNegative, col="RED")
plot(SeroPositive, main="Sero-Positive")
#polygon(SeroPositive, col="RED")
plot(RapidVRapid, main="Rapid and Very Rapid AIDS Progressors")
#polygon(RapidVRapid, col="RED")
plot(SlowVSlow, main="Slow and Very Slow AIDS Progressors")
#polygon(SlowVSlow, col="RED")

Data1NonSyn <- Data1[Data1[,20]=="nonsynonymous SNV" | Data1[,20]=="stopgain" | Data1[,20]=="stoploss", ]

SeroNegativeNonSyn <- density(Data1NonSyn[,11])
HESeroNegativeNonSyn <- density(Data1NonSyn[,12])
SeroPositiveNonSyn <- density(Data1NonSyn[,13])
RapidVRapidNonSyn <- density(Data1NonSyn[,14])
SlowVSlowNonSyn <- density(Data1NonSyn[,15])

plot(SeroNegativeNonSyn, ylim=c(0,10), main="Nonsynonymous Sero-Negative")
#polygon(SeroNegativeNonSyn, col="RED")
plot(HESeroNegativeNonSyn, main="Nonsynonymous Highly Exposed Sero-Negative Only")
#polygon(HESeroNegativeNonSyn, col="RED")
plot(SeroPositiveNonSyn, ylim=c(0,10), main="Nonsynonymous Sero-Positive")
#polygon(SeroPositiveNonSyn, col="RED")
plot(RapidVRapidNonSyn, main="Nonsynonymous Rapid and Very Rapid AIDS Progressors")
#polygon(RapidVRapidNonSyn, col="RED")
plot(SlowVSlowNonSyn, main="Nonsynonymous Slow and Very Slow AIDS Progressors")
#polygon(SlowVSlowNonSyn, col="RED")

dev.off()
