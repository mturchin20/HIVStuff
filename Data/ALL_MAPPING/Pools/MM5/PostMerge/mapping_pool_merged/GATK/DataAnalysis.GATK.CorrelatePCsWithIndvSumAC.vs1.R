cmd_args = commandArgs()

#Data1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.DropIBD.EPACTSedit.ped
#Data2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.perIndvSumAC
#cmd_args[7] Ex:

Data1 <- read.table(cmd_args[5], header=FALSE)
Data2 <- read.table(cmd_args[6], header=TRUE)

#POOL98_01RL     POOL98_01RL     0       0       0       1 NA    NA      NA      1        0.0079          0.0160  0.0720          0.0296          0.0320          -0.0555         -0.0447         0.0014          0.0010          -0.0499
#1       1151620 .       G       A       66.71   VQSRTrancheSNP99.00to99.90      AA=g;AC=3;AF=1.703e-03;AN=1762;BaseQRankSum=-4.403;DP=4417;Dels=0.00;FS=0.000;HRun=3;HaplotypeScore=0.8537;InbreedingCoeff=-0.0226;MLEAC=1;MLEAF=5.675e-04;MQ=60.00;MQ0=0;MQRankSum=-0.639;QD=6.67;ReadPosRankSum=-3.655;VQSLOD=-1.193e+00;culprit=DP      GT:AD:DP:GQ:PL  2       2   

Data2.colNames <- colnames(Data2)
Data3 <- c()
Data3.colNamesUse <- c()

for (i in 1:nrow(Data1)) {
	for (j in 1:length(Data2.colNames)) {
		if (Data1[i,1] == Data2.colNames[j]) {
			Data3 <- rbind(Data3, Data2[,j])
			Data3.colNamesUse <- c(Data3.colNamesUse, as.character(Data1[i,1]))
		}
	}
}

#Data4 <- cbind(Data1[,1], Data3)
#Data4 <- rbind(c("IID", paste(Data2[,1], "_", Data2[,2], sep="")), Data4)

Data4 <- Data3

rownames(Data4) <- Data3.colNamesUse
colnames(Data4) <- c(paste(Data2[,1], "_", Data2[,2], sep=""))

corVals <- c()

for (k in 1:ncol(Data4)) {

	GenoUse <- Data4[!is.na(Data4[,k]),k]
	PC3Use <- Data1[!is.na(Data4[,k]),13]

	corVals <- c(corVals, cor(GenoUse, PC3Use))

}

Data5 <- rbind(colnames(Data4), corVals)

write.table(t(Data5), file="", quote=FALSE, row.names=FALSE, col.names=FALSE)

