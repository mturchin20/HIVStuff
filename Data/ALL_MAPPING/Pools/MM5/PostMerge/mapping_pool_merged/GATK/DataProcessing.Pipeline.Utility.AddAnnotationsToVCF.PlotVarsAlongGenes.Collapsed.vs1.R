cmd_args = commandArgs()

#Data1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/ForPeople/ForKevinO/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.20140925KevinIndvRequest.OnlySNPsWithVar.wAnnot.vs2.KevGenesOfInterest1.Rinput.Collapsed.gz 

#1       24171075        rs145410841     downstream      FUCA1   downstream      1
#1       24171543        rs4649119       downstream      FUCA1   downstream      16
#1       24172882        rs145900261     intronic        FUCA1   intronic        1
#1       24175064        rs142928994     intronic        FUCA1   intronic        1
#1       24175283        .       exonic  FUCA1   nonsynonymous_SNV       1
#1       24175763        rs12404321      intronic        FUCA1   intronic        6
#1       24180962        rs13551 exonic  FUCA1   nonsynonymous_SNV       11
#1       24181177        rs12748109      intronic        FUCA1   intronic        10
#1       24185877        rs12141409      intronic        FUCA1   intronic        8
#1       24189050        rs140384451     intronic        FUCA1   intronic        1


Data1 <- read.table(cmd_args[5], header=TRUE)

GeneIDs <- Data1[,5]

GetColor <- function(x) { val1 <- "GREEN"; 
	if (x == "nonsynonymous_SNV") { 
		val1 <- "RED"; 
	} else if (x == "synonymous_SNV") {
		val1 <- "PURPLE";
	} else { 
		val1 <- "BLUE"; 
	} 
	return(val1) 
}

for (gene in GeneIDs) {

	Data1gene <- Data1[Data1[,5]==gene,]

	jpeg(paste("/data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/ForPeople/ForKevinO/DataProcessing.Pipeline.Utility.AddAnnotationsToVCF.PlotVarsAlongGenes.Collapse.vs1.", gene, ".jpg", sep=""), height=1000, width=2000, res=300)

	ColorList <- sapply(Data1gene[,6], GetColor)

	plot(Data1gene[,2], Data1gene[,7], main=gene, col=ColorList)

	dev.off()
}

warnings()
