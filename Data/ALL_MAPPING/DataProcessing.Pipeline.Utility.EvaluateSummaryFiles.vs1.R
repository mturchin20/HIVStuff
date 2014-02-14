cmd_args = commandArgs()

#Data1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperfastQpostQCStats.vs1.output
#Data2 Ex: /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperRegionpostQCStats.vs1.output.reformatted 
#Data3 Ex: /home/pg/michaelt/Data/ALL_MAPPING/DataPrcoessing.Pipeline.Utility.GetperFullBampostQCStats.vs1.output.reformatted

Data1 <- read.table(cmd_args[5], header=FALSE)
Data2 <- read.csv(cmd_args[6], header=TRUE)
Data3 <- read.csv(cmd_args[7], header=TRUE)

#Data1[,5] <- as.numeric(as.character(Data1[,5]))
#Data1[,9] <- as.numeric(as.character(Data1[,9]))
#Data1[,11] <- as.numeric(as.character(Data1[,11]))

#jpeg(file="/home/pg/michaelt/Data/ALL_MAPPING/Results/Graphics/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.vs1.SummaryfastQPlots.jpeg", height=4000, width=4000, res=300)
#par(mfrow=c(3,2))

#dev.off()

jpeg(file="/home/pg/michaelt/Data/ALL_MAPPING/Results/Graphics/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.vs1.SummaryRegionPlots.jpeg", height=8000, width=4000, res=300)
par(mfrow=c(6,2))

#Data2 <- Data2[!is.na(Data2$TotalReadsPostQC),]

#ID POOL01-01RL Total_reads_dropped: 0 (136792 - 136792) DropMin: 0 DropMax: 0
#ID POOL01-01RL Total_reads_dropped: 0 (108050 - 108050) DropMin: 0 DropMax: 0

plot(Data1[,9], Data1[,9]/Data1[,5], xlab="Total Reads Dropped", ylab="Total % of Reads Dropped", main="Total fastQ Reads <Min Length Dropped: Count vs. Percent")
abline(lm(Data1[,9]/Data1[,5] ~ Data1[,9]), lwd=2, lty=3, col="RED")
plot(Data1[,11], Data1[,11]/Data1[,5], xlab="Total Reads Dropped", ylab="Total % of Reads Dropped", main="Total fastQ Reads >Max Length Dropped: Count vs. Percent")
abline(lm(Data1[,11]/Data1[,5] ~ Data1[,11]), lwd=2, lty=3, col="RED")
hist(Data2$TotalReadsPreQC, breaks=50, main="Total Reads PreQC")
abline(v=mean(Data2$TotalReadsPreQC), lwd=3, lty=3, col="RED")
hist(Data2$TotalReadsPostQC, breaks=50, main="Total Reads PostQC")
abline(v=mean(Data2$TotalReadsPostQC[!is.na(Data2$TotalReadsPostQC)]), lwd=3, lty=3, col="RED")
plot(Data2$TotalReadsDropped, Data2$TotalReadsDroppedPrcnt, xlab="Total Reads Dropped", ylab="Total % of Reads Dropped", main="Total Reads Dropped: Count vs. Percent")
abline(lm(Data2$TotalReadsDroppedPrcnt ~ Data2$TotalReadsDropped), lwd=2, lty=3, col="RED")
#hist(Data2$TotalReadsDroppedPrcnt, breaks=50, main="Total % Reads Dropped")
#abline(v=mean(Data2$TotalReadsDroppedPrcnt), lwd=3, lty=3, col="RED")
plot(Data2$TotalReadsQ10, Data2$TotalReadsQ10Prcnt, xlab="Total Reads Dropped", ylab="Total % of Reads Dropped", main="Total <Q10 Reads: Count vs. Percent")
abline(lm(Data2$TotalReadsQ10Prcnt ~ Data2$TotalReadsQ10), lwd=2, lty=3, col="RED")
plot(Data2$TotalReadsF4, Data2$TotalReadsF4Prcnt, xlab="F4 Reads", ylab="% of Total Reads", main="Total F4 Reads: Count vs. Percent")
abline(lm(Data2$TotalReadsF4Prcnt ~ Data2$TotalReadsF4), lwd=2, lty=3, col="RED")
plot(Data2$TotalReadsF256, Data2$TotalReadsF256Prcnt, xlab="F256 Reads", ylab="% of Total Reads", main="Total F256 Reads: Count vs. Percent")
abline(lm(Data2$TotalReadsF256Prcnt ~ Data2$TotalReadsF256), lwd=2, lty=3, col="RED")
hist(Data2$AverageReadLengthPreQC, breaks=50, main="Average Read Length PreQC")
abline(v=mean(Data2$AverageReadLengthPreQC[!is.na(Data2$AverageReadLengthPreQC)]), lwd=3, lty=3, col="RED")
hist(Data2$AverageReadLengthPostQC, breaks=50, main="Average Read Length PostQC")
abline(v=mean(Data2$AverageReadLengthPostQC[!is.na(Data2$AverageReadLengthPostQC)]), lwd=3, lty=3, col="RED")
hist(Data2$BedFileCoveragePostQC, breaks=50, main="Read Coverage Per File")
abline(v=mean(Data2$BedFileCoveragePostQC[!is.na(Data2$BedFileCoveragePostQC)]), lwd=3, lty=3, col="RED")

#TotalReadsF4,TotalReadsF4Prcnt,TotalReadsF256

dev.off()

jpeg(file="/home/pg/michaelt/Data/ALL_MAPPING/Results/Graphics/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.vs1.SummaryIndvPlots.jpeg", height=10000, width=4000, res=300)
par(mfrow=c(6,2))

hist(Data3$TotalReadsPreQC, breaks=50, main="Total Reads PreQC")
abline(v=mean(Data3$TotalReadsPreQC), lwd=3, lty=3, col="RED")
hist(Data3$TotalReadsPostQC, breaks=50, main="Total Reads per Individual PostQC", xlab="Total Reads")
abline(v=mean(Data3$TotalReadsPostQC), lwd=3, lty=3, col="RED")
mean(Data3$TotalReadsPostQC)
plot (Data3$TotalReadsPreQCForward, Data3$TotalReadsPreQCReverse, xlab="Total Reads PreQC Forward", ylab="Total Reads PreQC Reverse", main="PreQC Read Directionality: # Forward Reads vs. # Reverse Reads")
abline(lm(Data3$TotalReadsPreQCReverse ~ Data3$TotalReadsPreQCForward), lwd=2, lty=3, col="RED")
#hist(Data3$TotalReadsPreQCForward_Reverse, breaks=50, main="Forward/Reverse Reads PreQC")
#abline(v=mean(Data3$TotalReadsPreQCForward_Reverse), lwd=2, lty=3, col="RED")
plot (Data3$TotalReadsPostQCForward, Data3$TotalReadsPostQCReverse, xlab="Total Reads PreQC Forward", ylab="Total Reads PostQC Reverse", main="PostQC Read Directionality: # Forward Reads vs. # Reverse Reads")
abline(lm(Data3$TotalReadsPostQCReverse ~ Data3$TotalReadsPostQCForward), lwd=2, lty=3, col="RED")
#hist(Data3$TotalReadsPostQCForward_Reverse, breaks=50, main="Forward/Reverse Reads PostQC")
#abline(v=mean(Data3$TotalReadsPostQCForward_Reverse), lwd=3, lty=3, col="RED")
plot(Data3$PreQCMAPQmean, Data3$PreQCMAPQsd, xlab="PreQC MAPQ Mean", ylab="PreQC MAP SD", main="PreQC MAPQ: Mean vs. SD")
abline(lm(Data3$PreQCMAPQsd ~ Data3$PreQCMAPQmean), lwd=2, lty=3, col="RED")
#hist(Data3$PreQCMAPQmean, breaks=50, main="Mean MAPQ PreQC")
#abline(v=mean(Data3$PreQCMAPQmean), lwd=3, lty=3, col="RED")
plot(Data3$PostQCMAPQmean, Data3$PostQCMAPQsd, xlab="PostQC MAPQ Mean", ylab="PostQC MAPQ SD", main="PostQC MAPQ: Mean vs. SD")
abline(lm(Data3$PostQCMAPQsd ~ Data3$PostQCMAPQmean), lwd=2, lty=3, col="RED")
#hist(Data3$PostQCMAPQmean, breaks=50, main="Mean MAPQ PostQC")
#abline(v=mean(Data3$PostQCMAPQmean), lwd=3, lty=3, col="RED")
plot(Data3$PreQCMean, Data3$PreQCSD, xlab="PreQC Read Length Mean", ylab="PreQC Read Length Sd", main="PreQC Read Length: Mean vs. SD")
abline(lm(Data3$PreQCSD ~ Data3$PreQCMean), lwd=2, lty=3, col="RED")
#hist(Data3$PreQCMean, breaks=50, main="Mean Read Length PreQC")
#abline(v=mean(Data3$PreQCMean), lwd=3, lty=3, col="RED")
plot(Data3$PostQCMean, Data3$PostQCSD, xlab="PostQC Read Length Mean", ylab="PostQC Read Length Sd", main="PostQC Read Length: Mean vs. SD")
mean(Data3$PostQCMean)
mean(Data3$PostQCSD)
abline(lm(Data3$PostQCSD ~ Data3$PostQCMean), lwd=2, lty=3, col="RED")
#hist(Data3$PostQCMean, breaks=50, main="Mean read Length PostQC")
#abline(v=mean(Data3$PostQCMean), lwd=3, lty=3, col="RED")
hist(Data3$CoveragePreQC, breaks=50, main="Read Coverage per Indv PreQC")
abline(v=mean(Data3$CoveragePreQC), lwd=3, lty=3, col="RED")
hist(Data3$CoveragePostQC, breaks=50, main="Read Coverage per Individual PostQC", xlab="Read Coverage")
abline(v=mean(Data3$CoveragePostQC), lwd=3, lty=3, col="RED")
mean(Data3$CoveragePostQC)
plot(Data3$TotalReadsPostRmdupDropped, Data3$TotalReadsPostRmdupDroppedPercentage, xlab="Number of Reads Dropped", ylab="% Reads Dropped", main="Reads Dropped Duplicate Removal: # Reads vs. % Reads")
mean(Data3$TotalReadsPostRmdupDropped)
mean(Data3$TotalReadsPostRmdupDroppedPercentage)
abline(lm(Data3$TotalReadsPostRmdupDroppedPercentage ~ Data3$TotalReadsPostRmdupDropped), lwd=2, lty=3, col="RED")
#hist(Data3$TotalReadsPostRmdupDroppedPercentage, breaks=50, main="% Reads Dropped Post Dup Removal")
#abline(v=mean(Data3$TotalReadsPostRmdupDroppedPercentage), lwd=3, lty=3, col="RED")

dev.off()

#warnings()










