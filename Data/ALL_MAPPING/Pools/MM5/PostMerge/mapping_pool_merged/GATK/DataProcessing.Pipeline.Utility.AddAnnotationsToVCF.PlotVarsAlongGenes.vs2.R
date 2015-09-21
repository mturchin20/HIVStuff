cmd_args = commandArgs()

#Data1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/ForPeople/ForKevinO/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.20140925KevinIndvRequest.OnlySNPsWithVar.wAnnot.vs2.KevGenesOfInterest1.Rinput.Collapsed.gz 
#Data2 Ex: /home/michaelt/Data/UCSC/UCSC_hg19_CanonicalExonList.txt

#1       24171075        rs145410841     downstream      FUCA1   downstream      0       0       0       0       0       0       1       0       0       0       0      0
#1       24171543        rs4649119       downstream      FUCA1   downstream      1       2       1       1       2       2       2       1       2       0       2      0
#1       24172882        rs145900261     intronic        FUCA1   intronic        0       0       0       0       0       0       0       0       0       0       0      1
#1       24175064        rs142928994     intronic        FUCA1   intronic        0       0       0       1       0       0       0       0       0       0       0      0
#1       24175283        .       exonic  FUCA1   nonsynonymous_SNV       0       0       0       0       0       0       1       0       0       0       0       0
#1       24175763        rs12404321      intronic        FUCA1   intronic        1       1       0       1       1       0       2       0       0       0       0      0
#1       24180962        rs13551 exonic  FUCA1   nonsynonymous_SNV       0       1       1       0       1       2       1       1       2       0       2       0
#1       24181177        rs12748109      intronic        FUCA1   intronic        0       1       1       0       0       2       1       1       2       0       2      0
#1       24185877        rs12141409      intronic        FUCA1   intronic        0       1       1       0       0       0       1       1       2       0       2      0
#1       24189050        rs140384451     intronic        FUCA1   intronic        0       0       0       0       0       1       0       0       0       0       0      0

#chr11   3686816 3692614 3691025 3691171 uc001lyf.3      3       uc001lyf.3      CHRNA10
#chr11   3686816 3692614 3692481 3692614 uc001lyf.3      4       uc001lyf.3      CHRNA10
#chr11   3696239 3819022 3696239 3697606 uc001lyh.3      0       uc001lyh.3      NUP98
#chr11   3696239 3819022 3697738 3697850 uc001lyh.3      1       uc001lyh.3      NUP98
#chr11   3696239 3819022 3700783 3700938 uc001lyh.3      2       uc001lyh.3      NUP98


Data1 <- read.table(cmd_args[5], header=TRUE)
Data2 <- read.table(cmd_args[6], header=FALSE)

#head(Data1)

GeneIDs <- Data1[,5]

GetColor <- function(x) { val1 <- "GREEN"; 
	val1 <- NA
	if (x == "nonsynonymous_SNV") { 
		val1 <- "RED"; 
	} else if (x == "synonymous_SNV") {
		val1 <- "PURPLE";
	} else { 
		val1 <- "BLUE"; 
	} 
	return(val1) 
}

ZeroToNA <- function(x) {
	val1 <- 0
	if (x == 0) {
		val1 <- NA
	} else {
		val1 <- x
	}

	return(val1)

}


for (gene in GeneIDs) {
#for (gene in GeneIDs[1]) {
#for (i in 1:length(GeneIDs)) {

	Data1gene <- Data1[Data1[,5]==gene,]
	Data2gene <- Data2[Data2[,9]==gene,]

	jpeg(paste("/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/ForPeople/ForKevinO/DataProcessing.Pipeline.Utility.AddAnnotationsToVCF.PlotVarsAlongGenes.vs2.", gene, ".jpg", sep=""), height=2000, width=2500, res=300)
#	par(xpd=TRUE)
	par(mar=c(5.1,5.5,4.1,2.1))

	ColorList <- sapply(Data1gene[,6], GetColor)
	TotalACs <- apply(Data1gene[,7:ncol(Data1gene)], 1, sum)
	Singles <- apply(as.matrix(TotalACs, nrow=1), 1, function(x) { val1 <- NA; if (x == 1) { val1 <- "*" }; return(val1)})
	

	for (j in 7:ncol(Data1gene)) {
		if (j == 7) {
#			plot(Data1gene[,2], seq(1, ncol(Data1gene)-6, length.out=length(Data1gene[,2])), main=gene, type="n", ylab="Indv", xlab="Pos (in bp)", col=ColorList)
#			plot(Data1gene[,2], seq(1, ncol(Data1gene)-4, length.out=length(Data1gene[,2])), main=gene, type="n", ylab="Indv", xlab="Pos (in bp)", col=ColorList)
			plot(Data1gene[,2], seq(1, ncol(Data1gene)-4, length.out=length(Data1gene[,2])), main=gene, type="n", ylab="", xlab="Pos (in bp)", yaxt="n", col=ColorList)
#			axis(2, at=seq(1, ncol(Data1gene)-4, by=1), labels=c(colnames(Data1gene)[7:ncol(Data1gene)], "Exons", "Singletons"), las=2)
			axis(2, at=seq(1, ncol(Data1gene)-4, by=1), labels=c(matrix(unlist(strsplit(colnames(Data1gene)[7:ncol(Data1gene)], "X")), ncol=2, byrow=TRUE)[,2], "Exons", "Singletons"), las=2)
		}
		text(Data1gene[,2], j-6, labels=as.character(sapply(Data1gene[,j], ZeroToNA)), main=gene, col=ColorList)
	}

#	text(Data1gene[,2], ncol(Data1gene)-5, labels=as.character(TotalACs), col=ColorList) 
	for (k in 1:nrow(Data2gene)) {
		lines(c(Data2gene[k,4], Data2gene[k,5]), c(ncol(Data1gene)-5, ncol(Data1gene)-5), col="BLACK", lwd=3)
	}
	text(Data1gene[,2], ncol(Data1gene)-4, labels=as.character(Singles), cex=2, col=ColorList) 

	legend(Data1gene[1,2]-50, ncol(Data1gene)-1.4, c("Nonsyn", "Syn", "Intronic/UTR/Intergenic"), pch=c(1,1,1), col=c("RED", "PURPLE", "BLUE"), cex=.75, xpd=TRUE)

	dev.off()

}

warnings()
