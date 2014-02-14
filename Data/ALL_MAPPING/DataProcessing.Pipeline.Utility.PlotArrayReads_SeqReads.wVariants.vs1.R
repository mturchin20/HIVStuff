cmd_args = commandArgs()
Data1 <- read.table(cmd_args[5], header=FALSE) #Data1 Ex: /home/michaelt/LabStuff/StephensLab/HIVStuff/PG/OID41305_HG19_Match5_probes/OID41305_HG19_Match5_probe_coverage.chr4.bed
Data2 <- read.table(cmd_args[6], header=FALSE) #Data2 Ex:  
Data3 <- read.table(cmd_args[7], header=TRUE) #Data3 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/PostMerge/mapping_pool_merged/GATK/AllPools.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASS.lmiss
chrList <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, "X")
chrLngth <- c(247, 243, 199, 191, 181, 171, 159, 146, 140, 135, 134, 132, 114, 106, 100, 89, 79, 76, 63, 62, 47, 50, 155, 58)

#GetColor <- function(coverageList, basePair) {
GetColor <- function(basePair) {

	colorReturn <- NULL

	if (basePair %in% coverageBPs) {
		colorReturn <- "RED"
	}
	else {
		colorReturn <- "BLACK"
	}

	return(colorReturn)

}


DeltaAF <- mapply(dAF, rep(SHat2, length(Data1$V16)), rep(N, length(Data1$V16)), Pavg, Data1$V8)

#for (chr in chrList) {
#for (i in 1:23) {
for (i in 22:22) {

#	BeginningText <- paste("Processing Chromosome ", chrList[i], "...", sep="")
	print(paste("Processing Chromosome ", chrList[i], "...", sep=""))

	OutputFile1 <- paste(cmd_args[8], ".Chr", chrList[i], ".plot.jpg", sep="")
	maxLength <- chrLngth[i] * 1000000
	plotTitle <- paste("Chromosome ", chrList[i], ": Array Reads, Seq Reads & Called Variants", sep="")

	jpeg(file=OutputFile1, height=2000, width=2500, res=300)
	plot(NULL, xlim=c(0,maxLength), ylim=c(0,5), main=plotTitle, xlab="bp")

	coverageBPs <- c()

	#chr4    972761  973392

	Data1.Chr <- Data1[Data1[,1]==chrList[i],]
	for (line1 in 1:nrow(Data1.Chr)) {
		yVal1 = jitter(4)
		segments(Data1.Chr[line1, 2], yVal1, Data1.Chr[line1,3], yVal1, col="BROWN")
	
		coverageBPs <- c(coverageBPs, seq(Data1.Chr[line1,2], Data1.Chr[line1,3], 1))

	}

	Data2.Chr <- Data2[Data2[,1]==chrList[i],]
	for (line2 in 1:nrow(Data2.Chr)) {
		yVal2 = jitter(2, factor=3)
		segments(Data2.Chr[line2, 2], yVal2, Data2.Chr[line2,3], yVal2, col="BLUE")
	}

	Data3.Chr <- Data3[Data3[,1]==chrList[i],]
#	for (line3 in 1:nrow(Data3.Chr)) {
#		if (Data3.Chr[line3,2] %in% coverageBPs) {
#			points(Data3.Chr[line3,2], 1-Data3.Chr[line3,6], col="RED", pch=1)
#		}
#		else {
#			points(Data3.Chr[line3,2], 1-Data3.Chr[line3,6], col="BLACK", pch=1)
#		}
#	}

#	colorPlot <- mapply(GetColor, coverageBPs, Data3.Chr[,2])
	colorPlot <- mapply(GetColor, Data3.Chr[,2])

	points(Data3.Chr[,2], 1-Data3.Chr[,6], col=colorPlot, pch=1)


	rm(coverageBPs, Data1.Chr, Data2.Chr, Data3.Chr)

	dev.off()

}
