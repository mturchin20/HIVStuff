cmd_args = commandArgs()

#Data1 Ex: AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.wAA.DropOffTargetVariants.1kbWindow.95geno.recode.FreqInfo.AnnovarAnnotation.txt.gz

#Data1 <- read.csv(cmd_args[5], quote="", header=FALSE)
Data1 <- read.csv(cmd_args[5], quote="", stringsAsFactors=FALSE, header=FALSE)

Data1[1:5,1:10]

FnlRslts <- c("Method", "Chr", "Categ.", "N", "SeroNeg_Mean", "SeroNeg_SE", "SeroPos_Mean", "SeroPos_SE", "tValue", "N", "HESeroNeg_Mean", "HESeroNeg_SE", "SeroPos_Mean", "SeroPos_SE", "tValue", "N", "RapidVRapid_Mean", "RapidVRapid_SE", "SlowVSlow_Mean", "SlowVSlow_SE", "tValue")

SqdDif <- function(xi, mu) {
	val1 <- (xi - mu) ^ 2
	return(val1)
}

tVal <- function(x, y) {

	nx <- length(x)
	ny <- length(y)

	xbar <- mean(x)
	ybar <- mean(y)

        xsmpVar <- sum(mapply(SqdDif, x, xbar))
	ysmpVar <- sum(mapply(SqdDif, y, ybar))

	val2 <- (xbar - ybar) / sqrt( ( ( ( (nx - 1) * xsmpVar) + ( (ny - 1) * ysmpVar ) ) / (nx + ny - 2)) * ( 1 / nx) * (1 / ny))

	return(c(nx, signif(c(xbar, sqrt(xsmpVar/(nx-1))/sqrt(nx), ybar, sqrt(ysmpVar/(ny-1))/sqrt(ny), val2), 3)))

}

#Data1 <- as.matrix(Data1)

#Data1[,10] <- data.frame(as.numeric(as.character(Data1[,10])))[,1]
#Data1[,11] <- data.frame(as.numeric(as.character(Data1[,11])))[,1]
#Data1[,12] <- data.frame(as.numeric(as.character(Data1[,12])))[,1]
#Data1[,13] <- data.frame(as.numeric(as.character(Data1[,13])))[,1]
#Data1[,14] <- data.frame(as.numeric(as.character(Data1[,14])))[,1]
#Data1[,15] <- data.frame(as.numeric(as.character(Data1[,15])))[,1]
#Data1[,16] <- data.frame(as.numeric(as.character(Data1[,16])))[,1]
##Data1[,17] <- data.frame(as.numeric(as.character(Data1[,17])))[,1]

Data1Intronic <- Data1[Data1[,18]=="intronic",]
Data1Exonic <- Data1[Data1[,18]=="exonic",]

#Synonymous Analysis

Data1ExonicSyn <- Data1Exonic[Data1Exonic[,20]=="synonymous SNV", ]

Data1ExonicSynA <- Data1ExonicSyn[Data1ExonicSyn[,1]!="X",]
Data1ExonicSynX <- Data1ExonicSyn[Data1ExonicSyn[,1]=="X",]

Data1ExonicSynA_Rslts1st <- tVal(Data1ExonicSynA[,11], Data1ExonicSynA[,13])
Data1ExonicSynA_Rslts2nd <- tVal(Data1ExonicSynA[,12], Data1ExonicSynA[,13])
Data1ExonicSynA_Rslts3rd <- tVal(Data1ExonicSynA[,14], Data1ExonicSynA[,15])

FnlRslts <- rbind(FnlRslts, c("Syn", "A", "Syn", Data1ExonicSynA_Rslts1st, Data1ExonicSynA_Rslts2nd, Data1ExonicSynA_Rslts3rd))

Data1ExonicSynX_Rslts1st <- tVal(Data1ExonicSynX[,11], Data1ExonicSynX[,13])
Data1ExonicSynX_Rslts2nd <- tVal(Data1ExonicSynX[,12], Data1ExonicSynX[,13])
Data1ExonicSynX_Rslts3rd <- tVal(Data1ExonicSynX[,14], Data1ExonicSynX[,15])

FnlRslts <- rbind(FnlRslts, c("Syn", "X", "Syn", Data1ExonicSynX_Rslts1st, Data1ExonicSynX_Rslts2nd, Data1ExonicSynX_Rslts3rd ))


#Nonsynonymous Analysis

Data1ExonicNonSyn <- Data1Exonic[Data1Exonic[,20]=="nonsynonymous SNV" | Data1Exonic[,20]=="stopgain" | Data1Exonic[,20]=="stoploss", ]

Data1ExonicNonSynA <- Data1ExonicNonSyn[Data1ExonicNonSyn[,1]!="X",]
Data1ExonicNonSynX <- Data1ExonicNonSyn[Data1ExonicNonSyn[,1]=="X",]

Data1ExonicNonSynA_Rslts1st <- tVal(Data1ExonicNonSynA[,11], Data1ExonicNonSynA[,13])
Data1ExonicNonSynA_Rslts2nd <- tVal(Data1ExonicNonSynA[,12], Data1ExonicNonSynA[,13])
Data1ExonicNonSynA_Rslts3rd <- tVal(Data1ExonicNonSynA[,14], Data1ExonicNonSynA[,15])

FnlRslts <- rbind(FnlRslts, c("NonSyn", "A", "NonSyn", Data1ExonicNonSynA_Rslts1st, Data1ExonicNonSynA_Rslts2nd, Data1ExonicNonSynA_Rslts3rd))

Data1ExonicNonSynX_Rslts1st <- tVal(Data1ExonicNonSynX[,11], Data1ExonicNonSynX[,13])
Data1ExonicNonSynX_Rslts2nd <- tVal(Data1ExonicNonSynX[,12], Data1ExonicNonSynX[,13])
Data1ExonicNonSynX_Rslts3rd <- tVal(Data1ExonicNonSynX[,14], Data1ExonicNonSynX[,15])

FnlRslts <- rbind(FnlRslts, c("NonSyn", "X", "NonSyn", Data1ExonicNonSynX_Rslts1st, Data1ExonicNonSynX_Rslts2nd, Data1ExonicNonSynX_Rslts3rd))

#Order in terms of the columns of the input datafile Data1 -- Sift (26), PolyPhen (28), LRT (30) and MT (32)

#PolyPhen

Data1ExonicNonSynA_D <- Data1ExonicNonSynA[Data1ExonicNonSynA[,28]=="D",]
Data1ExonicNonSynA_P <- Data1ExonicNonSynA[Data1ExonicNonSynA[,28]=="P",]
Data1ExonicNonSynA_B <- Data1ExonicNonSynA[Data1ExonicNonSynA[,28]=="B",]
#Data1ExonicNonSynA_N <- Data1ExonicNonSynA[Data1ExonicNonSynA[,28]=="N",]

Data1ExonicNonSynA_DRslts1st <- tVal(Data1ExonicNonSynA_D[,11], Data1ExonicNonSynA_D[,13])
Data1ExonicNonSynA_DRslts2nd <- tVal(Data1ExonicNonSynA_D[,12], Data1ExonicNonSynA_D[,13])
Data1ExonicNonSynA_DRslts3rd <- tVal(Data1ExonicNonSynA_D[,14], Data1ExonicNonSynA_D[,15])
Data1ExonicNonSynA_PRslts1st <- tVal(Data1ExonicNonSynA_P[,11], Data1ExonicNonSynA_P[,13])
Data1ExonicNonSynA_PRslts2nd <- tVal(Data1ExonicNonSynA_P[,12], Data1ExonicNonSynA_P[,13])
Data1ExonicNonSynA_PRslts3rd <- tVal(Data1ExonicNonSynA_P[,14], Data1ExonicNonSynA_P[,15])
Data1ExonicNonSynA_BRslts1st <- tVal(Data1ExonicNonSynA_B[,11], Data1ExonicNonSynA_B[,13])
Data1ExonicNonSynA_BRslts2nd <- tVal(Data1ExonicNonSynA_B[,12], Data1ExonicNonSynA_B[,13])
Data1ExonicNonSynA_BRslts3rd <- tVal(Data1ExonicNonSynA_B[,14], Data1ExonicNonSynA_B[,15])
#Data1ExonicNonSynA_NRslts1st <- tVal(Data1ExonicNonSynA_N[,8], Data1ExonicNonSynA_N[,11])

FnlRslts <- rbind(FnlRslts, c("PP_2", "A", "D", Data1ExonicNonSynA_DRslts1st, Data1ExonicNonSynA_DRslts2nd, Data1ExonicNonSynA_DRslts3rd))
FnlRslts <- rbind(FnlRslts, c("PP_2", "A", "P", Data1ExonicNonSynA_PRslts1st, Data1ExonicNonSynA_PRslts2nd, Data1ExonicNonSynA_PRslts3rd))
FnlRslts <- rbind(FnlRslts, c("PP_2", "A", "B", Data1ExonicNonSynA_BRslts1st, Data1ExonicNonSynA_BRslts2nd, Data1ExonicNonSynA_BRslts3rd))
#FnlRslts <- rbind(FnlRslts, c("PP_2", "A", "N", Data1ExonicNonSynA_NRslts))

Data1ExonicNonSynX_D <- Data1ExonicNonSynX[Data1ExonicNonSynX[,28]=="D",]
Data1ExonicNonSynX_P <- Data1ExonicNonSynX[Data1ExonicNonSynX[,28]=="P",]
Data1ExonicNonSynX_B <- Data1ExonicNonSynX[Data1ExonicNonSynX[,28]=="B",]
#Data1ExonicNonSynX_N <- Data1ExonicNonSynX[Data1ExonicNonSynX[,28]=="N",]

Data1ExonicNonSynX_DRslts1st <- tVal(Data1ExonicNonSynX_D[,11], Data1ExonicNonSynX_D[,13])
Data1ExonicNonSynX_DRslts2nd <- tVal(Data1ExonicNonSynX_D[,12], Data1ExonicNonSynX_D[,13])
Data1ExonicNonSynX_DRslts3rd <- tVal(Data1ExonicNonSynX_D[,14], Data1ExonicNonSynX_D[,15])
Data1ExonicNonSynX_PRslts1st <- tVal(Data1ExonicNonSynX_P[,11], Data1ExonicNonSynX_P[,13])
Data1ExonicNonSynX_PRslts2nd <- tVal(Data1ExonicNonSynX_P[,12], Data1ExonicNonSynX_P[,13])
Data1ExonicNonSynX_PRslts3rd <- tVal(Data1ExonicNonSynX_P[,14], Data1ExonicNonSynX_P[,15])
Data1ExonicNonSynX_BRslts1st <- tVal(Data1ExonicNonSynX_B[,11], Data1ExonicNonSynX_B[,13])
Data1ExonicNonSynX_BRslts2nd <- tVal(Data1ExonicNonSynX_B[,12], Data1ExonicNonSynX_B[,13])
Data1ExonicNonSynX_BRslts3rd <- tVal(Data1ExonicNonSynX_B[,14], Data1ExonicNonSynX_B[,15])
#Data1ExonicNonSynX_NRslts1st <- tVal(Data1ExonicNonSynX_N[,8], Data1ExonicNonSynX_N[,11])
#Data1ExonicNonSynX_NRslts <- tVal(Data1ExonicNonSynX_N[,8], Data1ExonicNonSynX_N[,11])

FnlRslts <- rbind(FnlRslts, c("PP_2", "X", "D", Data1ExonicNonSynX_DRslts1st, Data1ExonicNonSynX_DRslts2nd, Data1ExonicNonSynX_DRslts3rd))
FnlRslts <- rbind(FnlRslts, c("PP_2", "X", "P", Data1ExonicNonSynX_PRslts1st, Data1ExonicNonSynX_PRslts2nd, Data1ExonicNonSynX_PRslts3rd))
FnlRslts <- rbind(FnlRslts, c("PP_2", "X", "B", Data1ExonicNonSynX_BRslts1st, Data1ExonicNonSynX_BRslts2nd, Data1ExonicNonSynX_BRslts3rd))
#FnlRslts <- rbind(FnlRslts, c("PP_2", "X", "N", Data1ExonicNonSynX_NRslts))

write.table(FnlRslts, "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.CalcMeandAF.vs1.ExomeWideAnalyses.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)


#Individual Gene Analyses

GeneIDs <- unique(Data1$V19)
FnlRslts_GeneAnalyses <- c()

for (Gene in GeneIDs) {

	Data1ExonicNonSyn_Gene <- Data1ExonicNonSyn[Data1ExonicNonSyn$V19==Gene,]

	if (length(Data1ExonicNonSyn_Gene[,1]) > 3) {
		FnlRslts_GeneAnalyses <- rbind(FnlRslts_GeneAnalyses, c("Nonsyn", Gene, "Pheno1", tVal(Data1ExonicNonSyn_Gene[,11], Data1ExonicNonSyn_Gene[,13])))
		FnlRslts_GeneAnalyses <- rbind(FnlRslts_GeneAnalyses, c("Nonsyn", Gene, "Pheno2", tVal(Data1ExonicNonSyn_Gene[,12], Data1ExonicNonSyn_Gene[,13])))
		FnlRslts_GeneAnalyses <- rbind(FnlRslts_GeneAnalyses, c("Nonsyn", Gene, "Pheno3", tVal(Data1ExonicNonSyn_Gene[,14], Data1ExonicNonSyn_Gene[,15])))
	}

}

Data1ExonicNonSyn_D <- Data1ExonicNonSyn[Data1ExonicNonSyn[,28]=="D",]

FnlRslts_GeneAnalyses_PP2D <- c()

for (Gene in GeneIDs) {

	Data1ExonicNonSyn_DGene <- Data1ExonicNonSyn_D[Data1ExonicNonSyn_D$V19==Gene,]

	if (length(Data1ExonicNonSyn_DGene[,1]) > 3) {
		FnlRslts_GeneAnalyses_PP2D <- rbind(FnlRslts_GeneAnalyses_PP2D, c("PP2D", Gene, "Pheno1", tVal(Data1ExonicNonSyn_DGene[,11], Data1ExonicNonSyn_DGene[,13])))
		FnlRslts_GeneAnalyses_PP2D <- rbind(FnlRslts_GeneAnalyses_PP2D, c("PP2D", Gene, "Pheno2", tVal(Data1ExonicNonSyn_DGene[,12], Data1ExonicNonSyn_DGene[,13])))
		FnlRslts_GeneAnalyses_PP2D <- rbind(FnlRslts_GeneAnalyses_PP2D, c("PP2D", Gene, "Pheno3", tVal(Data1ExonicNonSyn_DGene[,14], Data1ExonicNonSyn_DGene[,15])))
	}

}

Data1ExonicNonSyn_DP <- Data1ExonicNonSyn[Data1ExonicNonSyn[,28]=="D" | Data1ExonicNonSyn[,28]=="P",]

FnlRslts_GeneAnalyses_PP2DP <- c()

for (Gene in GeneIDs) {

	Data1ExonicNonSyn_DPGene <- Data1ExonicNonSyn_DP[Data1ExonicNonSyn_DP$V19==Gene,]

	if (length(Data1ExonicNonSyn_DPGene[,1]) > 3) {
		FnlRslts_GeneAnalyses_PP2DP <- rbind(FnlRslts_GeneAnalyses_PP2DP, c("PP2DP", Gene, "Pheno1", tVal(Data1ExonicNonSyn_DPGene[,11], Data1ExonicNonSyn_DPGene[,13])))
		FnlRslts_GeneAnalyses_PP2DP <- rbind(FnlRslts_GeneAnalyses_PP2DP, c("PP2DP", Gene, "Pheno2", tVal(Data1ExonicNonSyn_DPGene[,12], Data1ExonicNonSyn_DPGene[,13])))
		FnlRslts_GeneAnalyses_PP2DP <- rbind(FnlRslts_GeneAnalyses_PP2DP, c("PP2DP", Gene, "Pheno3", tVal(Data1ExonicNonSyn_DPGene[,14], Data1ExonicNonSyn_DPGene[,15])))
	}

}

FnlRslts_GeneAnalyses_All <- rbind(FnlRslts_GeneAnalyses, FnlRslts_GeneAnalyses_PP2D, FnlRslts_GeneAnalyses_PP2DP)

write.table(FnlRslts_GeneAnalyses_All, "/home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/OutputFiles/DataProcessing.Pipeline.Utility.CalcMeandAF.vs1.GeneSpecificAnalyses.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

