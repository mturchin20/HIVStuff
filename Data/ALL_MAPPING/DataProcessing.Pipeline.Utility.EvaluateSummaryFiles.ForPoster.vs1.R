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

jpeg(file="/home/pg/michaelt/Data/ALL_MAPPING/OutputFiles/Graphics/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.ForPoster.vs1.TotalReadsPostQC.jpeg", height=2750, width=2750, res=300)
par(mar=c(5, 5, 4, 2) + 0.1)

hist(Data3$TotalReadsPostQC, breaks=50, main="Total Reads per Individual PostQC", xlab="Total Reads", cex.main=2.3, cex.lab=2.3, cex.axis=2.3, cex=2.3)
abline(v=mean(Data3$TotalReadsPostQC), lwd=5, lty=3, col="RED")
mean(Data3$TotalReadsPostQC)

legend("topright", legend=c(round(mean(Data3$TotalReadsPostQC))), lty=c(3), lwd=c(5), col="RED", cex=1.75)

dev.off()

jpeg(file="/home/pg/michaelt/Data/ALL_MAPPING/OutputFiles/Graphics/DataProcessing.Pipeline.Utility.EvaluateSummaryFiles.ForPoster.vs1.TotalCoveragePostQC.jpeg", height=2750, width=2750, res=300)
par(mar=c(5, 5, 4, 2) + 0.1)

hist(Data3$CoveragePostQC, breaks=50, main="Read Coverage per Individual PostQC", xlab="Read Coverage", cex.main=2.3, cex.lab=2.3, cex.axis=2.3, cex=2.3)
abline(v=mean(Data3$CoveragePostQC), lwd=5, lty=3, col="RED")
mean(Data3$CoveragePostQC)

legend("topright", legend=c(round(mean(Data3$CoveragePostQC))), lty=c(3), lwd=c(5), col="RED", cex=1.75)

dev.off()

#warnings()










