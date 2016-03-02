cmd_args = commandArgs()

#Data1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/TruePheno/Pheno1/Exonic.Nonsynonymous/DataProcessing.Pipeline.Utility.CollectPValsPerGeneAcrossMultRuns.vs2.TruePheno.Pheno1.Exonic.Nonsynonymous.output.noNAs.Routput
#Data2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/FakePheno/Pheno1/Exonic.Nonsynonymous/DataProcessing.Pipeline.Utility.CollectPValsPerRankAcrossMultRuns.vs2.FakePheno.Pheno1.Exonic.Nonsynonymous.output.noNAs.Routput
#cmd_args[7] (jpeg file location) Ex:
#cmd_args[8] (Array) Ex: MM5
#cmd_args[9] (Phenotype) Ex: Pheno1

Data1 <- read.table(cmd_args[5], header=FALSE, row.names=1)
Data2 <- read.table(cmd_args[6], header=FALSE, row.names=1)
#Data2.neglog10 <- Data2
#Data2.neglog10[,1] <- -1*log10(Data2.neglog10[,1])
#Data2.neglog10[,2] <- -1*log10(Data2.neglog10[,2])
#Data2.neglog10[,3] <- -1*log10(Data2.neglog10[,3])
#cmd_args[8] <- as.character(cmd_args[8])
#cmd_args[9] <- as.character(cmd_args[9])

print(Data2[115,])
#print(Data2.neglog10[3,])
#print(c(cmd_args[8], cmd_args[9]))

#SDHD            0.0062799510 5.324625e-04 0.29264
#[464,] 0.016472894 0.004522072 0.64342

xVals1 <- c(1:nrow(Data1))/(nrow(Data1))
head(xVals1)

GetCIs <- function(x) {
#	print(x)
	if (is.infinite(x[2])) {
		x[2] <- 0
	}
	Lower <- x[1] - (2*x[2])
	if (Lower < 0) {
		Lower <- .00000001
	}
	Upper <- x[1] + (2*x[2]) 
	return(c(Lower,Upper))
}

#CIs <- apply(Data2.neglog10, 1, GetCIs)
CIs <- apply(Data2, 1, GetCIs)

length(xVals1)
dim(CIs)

jpeg(file=cmd_args[7], height=4000, width=5000, res=300)
par(mfrow=c(2,2))

title <- NULL
if (cmd_args[9] == "Pheno1") {
	title <- paste(cmd_args[8], "_SKAT-O_HIVAcquisition_Nonsyn", sep="")
} else if (cmd_args[9] == "Pheno2") {
	title <- paste(cmd_args[8], "_SKAT-O_HIVAcquistionHE_Nonsyn", sep="")
} else if (cmd_args[9] == "Pheno3") {
	title <- paste(cmd_args[8], "_SKAT-O_AIDSProgression_Nonsyn", sep="")
} else if (cmd_args[9] == "Pheno4") {
	title <- paste(cmd_args[8], "_SKAT-O_AIDSProgressionExtr_Nonsyn", sep="")
} else {
	title <- "NoCorrectPhenotypeTitleUsed"
}

hist(Data1[,1], xlab="p-Values", main=title, breaks=50)

#plot(rev(-log10(xVals1)), -log10(Data1[,1]), xlab="-log10 Expected p-Values", ylim=c(0,4), ylab="-log10 Observed p-Values", main=cmd_args[8], col="RED")
plot(rev(-log10(xVals1)), -log10(Data1[,1]), xlab="-log10 Expected p-Values", ylim=c(0,4), ylab="-log10 Observed p-Values", main=title, col="RED")
abline(a=0, b=1)

polygon(c(rev(-log10(xVals1)), -log10(xVals1)), c(-log10(CIs[1,]), rev(-log10(CIs[2,]))), density=50, col="GRAY", border="BLUE")

##legend(0,4, c("Observed", "95% CI"), pch=c(1, NA),  col=c("RED", NA), fill=c(NULL, "GRAY"), density=c(NA, 50), border=c(NA,"BLUE"))
#legend(0,4, c("Observed", "95% CI"), pch=c(1, 22),  col=c("RED", "BLUE"), pt.bg=c(NA,"GRAY"))
legend(0,4, c("Observed", NA), pch=c(1, NA),  col=c("RED", NA))
legend(-.0265, 4, c(NA, "95% CI"), fill=c("WHITE", "GRAY"), density=c(0, 50), border=c(NA,"BLUE"), bty="n", x.intersp = 0.65)

points(rev(-log10(xVals1)), -log10(Data1[,1]), col="RED")

allPermPvals <- sort(as.matrix(unlist(Data2), ncol=1))
xVals2 <- c(1:nrow(allPermPvals))/(nrow(allPermPvals))
head(xVals2)
plot(rev(-log10(xVals2)), rev(-log10(allPermPvals)), xlab="-log10 Expected p-Values", ylim=c(0,4), ylab="-log10 Observed p-Values", main=paste(title, " -- All Permuted p-Values"), col="RED")
abline(a=0, b=1)

hist(allPermPvals, xlab="p-Values", main=paste(title, " -- All Permuted p-Values"))

dev.off()





